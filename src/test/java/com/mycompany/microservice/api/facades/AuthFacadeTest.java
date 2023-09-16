package com.mycompany.microservice.api.facades;

import static com.mycompany.microservice.api.constants.JWTClaims.CLAIM_EMAIL;

import com.mycompany.microservice.api.infra.auth.providers.ApiKeyAuthentication;
import com.mycompany.microservice.api.infra.auth.providers.ApiKeyAuthentication.ApiKeyDetails;
import java.util.Collections;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

public class AuthFacadeTest {

  public static String API_KEY = "my-apikey-test";
  public static String EMAIL = "test@gmail.com";
  public static String COMPANY_SLUG = "my-company-test";

  @Test
  void verifyGetCompanySlugIsEmptyOnEmptyAuthentication() {
    final var securityContext = Mockito.mock(SecurityContext.class);
    SecurityContextHolder.setContext(securityContext);

    Assertions.assertEquals(StringUtils.EMPTY, AuthFacade.getCompanySlug());
  }

  @Test
  void verifyGetCompanySlugIsEmptyOnInvalidAuthentication() {
    final var securityContext = Mockito.mock(SecurityContext.class);
    final var authentication = Mockito.mock(Authentication.class);

    Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
    SecurityContextHolder.setContext(securityContext);

    Assertions.assertTrue(AuthFacade.getCompanySlug().isEmpty());
  }

  @Test
  void verifyGetCompanySlugOnJwtAuthentication() {

    final var jwt =
        Jwt.withTokenValue("token")
            .header("alg", "none")
            .claim("scope", "read")
            .claim("company_slug", COMPANY_SLUG)
            .build();

    final var securityContext = Mockito.mock(SecurityContext.class);
    final var authentication = new JwtAuthenticationToken(jwt, AuthorityUtils.NO_AUTHORITIES);

    Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
    SecurityContextHolder.setContext(securityContext);

    Assertions.assertEquals(AuthFacade.getCompanySlug(), COMPANY_SLUG);
  }

  @Test
  void verifyGetUserEmailOnJwtAuthentication() {

    final var jwt =
        Jwt.withTokenValue("token")
            .header("alg", "none")
            .claim("scope", "read")
            .claim(CLAIM_EMAIL, EMAIL)
            .build();

    final var securityContext = Mockito.mock(SecurityContext.class);
    final var authentication = new JwtAuthenticationToken(jwt, AuthorityUtils.NO_AUTHORITIES);

    Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
    SecurityContextHolder.setContext(securityContext);

    Assertions.assertEquals(AuthFacade.getUserEmail(), EMAIL);
  }

  @Test
  void verifyGetCompanySlugOnApiAuthentication() {

    final var authentication =
        new ApiKeyAuthentication(
            API_KEY,
            true,
            ApiKeyDetails.builder().id(1L).companySlug(COMPANY_SLUG).build(),
            Collections.emptyList());

    final var securityContext = Mockito.mock(SecurityContext.class);
    Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
    SecurityContextHolder.setContext(securityContext);

    Assertions.assertEquals(AuthFacade.getCompanySlug(), COMPANY_SLUG);
  }

  @Test
  void verifyGetUserEmailOnApiAuthentication() {

    final var authentication =
        new ApiKeyAuthentication(
            API_KEY,
            true,
            ApiKeyDetails.builder().id(1L).email(EMAIL).build(),
            Collections.emptyList());

    final var securityContext = Mockito.mock(SecurityContext.class);
    Mockito.when(securityContext.getAuthentication()).thenReturn(authentication);
    SecurityContextHolder.setContext(securityContext);

    Assertions.assertEquals(AuthFacade.getUserEmail(), EMAIL);
  }
}
