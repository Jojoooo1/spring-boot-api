package com.mycompany.microservice.api.infra.security;

import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_REALM_ACCESS;
import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_ROLES;
import static com.mycompany.microservice.api.enums.UserRolesEnum.*;
import static java.lang.String.format;

import com.mycompany.microservice.api.constants.AppUrls;
import com.mycompany.microservice.api.infra.auth.filters.ApiKeyProcessingFilter;
import com.mycompany.microservice.api.infra.auth.provider.apikey.ApiKeyAuthenticationProvider;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AnonymousAuthenticationFilter;

@Slf4j
@Configuration
@EnableMethodSecurity
@EnableWebSecurity
public class SecurityConfiguration {

  @Bean
  public AuthenticationProvider companyApiKeyAuthenticationProvider() {
    return new ApiKeyAuthenticationProvider();
  }

  @Bean
  public AuthenticationManager authenticationManager() {
    return new ProviderManager(
        Collections.singletonList(this.companyApiKeyAuthenticationProvider()));
  }

  @Bean
  public SecurityFilterChain securityFilterChain(final HttpSecurity http) throws Exception {
    http.addFilterBefore(
            new ApiKeyProcessingFilter(AppUrls.MANAGEMENT + "/**", this.authenticationManager()),
            AnonymousAuthenticationFilter.class)
        .addFilterBefore(
            new ApiKeyProcessingFilter(AppUrls.INTERNAL + "/**", this.authenticationManager()),
            AnonymousAuthenticationFilter.class)
        .addFilterBefore(
            new ApiKeyProcessingFilter(AppUrls.API + "/**", this.authenticationManager()),
            AnonymousAuthenticationFilter.class)
        .authorizeHttpRequests(
            authorize ->
                authorize
                    // Uncomment if you want to show uncaught error message details.
                    // .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR)
                    // .permitAll()

                    // Client API (ex: used by your clients)
                    .requestMatchers(AppUrls.MANAGEMENT + "/**")
                    .authenticated()

                    // Management API (ex: used by dev team)
                    .requestMatchers(AppUrls.INTERNAL + "/**")
                    .authenticated()

                    // Management API (ex: used by dev team)
                    .requestMatchers(AppUrls.API + "/**")
                    .authenticated()

                    // Mobile applications (ex: used by your users)
                    .requestMatchers(AppUrls.MOBILE_APP + "/**")
                    .hasAnyRole(MOBILE_USER.getSlug(), MOBILE_ADMIN.getSlug())

                    // Backoffice applications (ex: used by your operational team)
                    .requestMatchers(AppUrls.BACK_OFFICE_APP + "/**")
                    .hasAnyRole(BACK_OFFICE_USER.getSlug(), BACK_OFFICE_ADMIN.getSlug())

                    // Public API
                    .requestMatchers(AppUrls.PUBLIC + "/**")
                    .permitAll()

                    // Actuator (will use different management port in production)
                    .requestMatchers("/actuator/**")
                    .permitAll()

                    // Else return 401
                    .anyRequest()
                    .denyAll())

        // To prevent any misconfiguration we disable explicitly all authentication scheme
        .sessionManagement(
            session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        .csrf(AbstractHttpConfigurer::disable)
        .httpBasic(AbstractHttpConfigurer::disable)
        .formLogin(AbstractHttpConfigurer::disable)
        .logout(AbstractHttpConfigurer::disable)
        .oauth2ResourceServer(
            oauth2 ->
                oauth2.jwt(
                    jwtConfigurer ->
                        jwtConfigurer.jwtAuthenticationConverter(
                            this::getKeycloakJwtAuthenticationToken)));

    return http.build();
  }

  private JwtAuthenticationToken getKeycloakJwtAuthenticationToken(final Jwt jwt) {
    final Map<String, Collection<String>> realmAccess = jwt.getClaim(CLAIM_REALM_ACCESS);

    if (realmAccess == null) {
      log.warn(
          format("realm_access is null for jwt %s verify realm configuration.", jwt.getClaims()));
      return new JwtAuthenticationToken(jwt, Collections.emptyList());
    }

    final Collection<String> roles = realmAccess.get(CLAIM_ROLES);

    if (roles == null) {
      log.warn(
          format(
              "realm_access.roles is null for jwt %s verify realm configuration.",
              jwt.getClaims()));
      return new JwtAuthenticationToken(jwt, Collections.emptyList());
    }

    final List<SimpleGrantedAuthority> grantedAuthorities =
        roles.stream()
            .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
            .collect(Collectors.toList());
    return new JwtAuthenticationToken(jwt, grantedAuthorities);
  }
}
