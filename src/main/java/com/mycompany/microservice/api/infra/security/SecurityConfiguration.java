package com.mycompany.microservice.api.infra.security;

import static com.mycompany.microservice.api.enums.UserRolesEnum.*;

import com.mycompany.microservice.api.constants.AppUrls;
import com.mycompany.microservice.api.infra.auth.converters.KeycloakJwtConverter;
import com.mycompany.microservice.api.infra.auth.filters.ApiKeyProcessingFilter;
import com.mycompany.microservice.api.infra.auth.providers.ApiKeyAuthenticationProvider;
import java.util.Collections;
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
        // Necessary if we want to be able to call POST/PUT/DELETE
        .csrf(AbstractHttpConfigurer::disable)
        // To prevent any misconfiguration we disable explicitly all authentication scheme
        .sessionManagement(
            session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        .httpBasic(AbstractHttpConfigurer::disable)
        .formLogin(AbstractHttpConfigurer::disable)
        .logout(AbstractHttpConfigurer::disable)
        .oauth2ResourceServer(
            oauth2 ->
                oauth2.jwt(jwt -> jwt.jwtAuthenticationConverter(new KeycloakJwtConverter())));

    return http.build();
  }
}
