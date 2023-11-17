package com.mycompany.microservice.api.infra.auth.converters;

import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_EMAIL;
import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_REALM_ACCESS;
import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_ROLES;
import static java.lang.String.format;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.convert.converter.Converter;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

@Slf4j
@RequiredArgsConstructor
public class KeycloakJwtConverter implements Converter<Jwt, AbstractAuthenticationToken> {

  @Override
  public AbstractAuthenticationToken convert(@NonNull final Jwt jwt) {
    final Collection<GrantedAuthority> authorities = this.extractRealmAccessRoles(jwt);
    return new JwtAuthenticationToken(jwt, authorities, this.extractEmail(jwt));
  }

  private Collection<GrantedAuthority> extractRealmAccessRoles(final Jwt jwt) {
    final Map<String, Collection<String>> realmAccess = jwt.getClaim(CLAIM_REALM_ACCESS);

    if (realmAccess == null) {
      log.warn(
          format("realm_access is null for jwt %s verify realm configuration.", jwt.getClaims()));
      return Collections.emptyList();
    }

    final Collection<String> realmAccessRoles = realmAccess.get(CLAIM_ROLES);

    if (realmAccessRoles == null) {
      log.warn(
          format(
              "realm_access.roles is null for jwt %s verify realm configuration.",
              jwt.getClaims()));
      return Collections.emptyList();
    }

    return realmAccessRoles.stream()
        .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
        .collect(Collectors.toSet());
  }

  private String extractEmail(final Jwt jwt) {
    final String email = jwt.getClaimAsString(CLAIM_EMAIL);
    return StringUtils.isNotBlank(email) ? email : StringUtils.EMPTY;
  }
}
