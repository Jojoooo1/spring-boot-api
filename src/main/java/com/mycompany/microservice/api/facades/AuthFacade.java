package com.mycompany.microservice.api.facades;

import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_COMPANY_SLUG;
import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_EMAIL;

import com.mycompany.microservice.api.exceptions.InternalServerErrorException;
import com.mycompany.microservice.api.infra.auth.providers.ApiKeyAuthentication;
import com.mycompany.microservice.api.infra.auth.providers.ApiKeyAuthentication.ApiKeyDetails;
import java.util.Optional;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

@Slf4j
@UtilityClass
public class AuthFacade {

  public static String getCompanySlug() {
    return getCompanySlugOptional().orElse(StringUtils.EMPTY);
  }

  public static String getUserEmail() {
    return getUserEmailOptional().orElse(StringUtils.EMPTY);
  }

  public static Optional<String> getCompanySlugOptional() {
    try {

      final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

      if (isJWT(authentication)) {
        return getCompanySlugFromJwt((Jwt) authentication.getPrincipal());
      } else if (isApiKey(authentication)) {
        return getCompanySlugFromApikey(authentication);
      }

      return Optional.empty();

    } catch (final Exception ex) {
      log.error("error getting company_slug from AuthFacade", ex);
      throw new InternalServerErrorException();
    }
  }

  public static Optional<String> getUserEmailOptional() {
    try {

      final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

      if (isJWT(authentication)) {
        final Jwt jwt = (Jwt) authentication.getPrincipal();
        return Optional.ofNullable(jwt.getClaimAsString(CLAIM_EMAIL));

      } else if (isApiKey(authentication)) {
        final ApiKeyAuthentication apiKeyAuthentication = (ApiKeyAuthentication) authentication;
        return Optional.ofNullable(apiKeyAuthentication.getApiKeyDetails().getEmail());
      }

      return Optional.empty();

    } catch (final Exception ex) {
      log.error("error getting user_email from AuthFacade", ex);
      throw new InternalServerErrorException();
    }
  }

  private boolean isJWT(final Authentication authentication) {
    return (authentication instanceof Jwt || authentication instanceof JwtAuthenticationToken);
  }

  private boolean isApiKey(final Authentication authentication) {
    return authentication instanceof ApiKeyAuthentication;
  }

  private Optional<String> getCompanySlugFromJwt(final Jwt jwt) {
    final Optional<String> companySlugOptional =
        Optional.ofNullable(jwt.getClaimAsString(CLAIM_COMPANY_SLUG));

    if (companySlugOptional.isEmpty()) {
      log.warn("user '{}' does not have a company_slug", jwt.getClaimAsString(CLAIM_EMAIL));
    }

    return companySlugOptional;
  }

  private Optional<String> getCompanySlugFromApikey(final Authentication authentication) {

    final ApiKeyAuthentication apiKeyAuthentication = (ApiKeyAuthentication) authentication;
    final ApiKeyDetails apiKeyDetails = apiKeyAuthentication.getApiKeyDetails();

    if (StringUtils.isBlank(apiKeyDetails.getCompanySlug())) {
      log.warn("api-key '{}' does not have a company_slug", apiKeyDetails.getId());
    }

    return Optional.ofNullable(apiKeyDetails.getCompanySlug());
  }
}
