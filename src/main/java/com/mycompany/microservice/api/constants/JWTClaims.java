package com.mycompany.microservice.api.constants;

import lombok.experimental.UtilityClass;

@UtilityClass
public class JWTClaims {
  public static final String CLAIM_COMPANY_SLUG = "company_slug";
  public static final String CLAIM_EMAIL = "email";
  public static final String CLAIM_REALM_ACCESS = "realm_access";
  public static final String CLAIM_ROLES = "roles";
  public static final String CLAIM_ISSUER = "iss";
}
