package com.mycompany.microservice.api.infra.auth.provider.apikey;

import java.io.Serial;
import lombok.Getter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.Transient;
import org.springframework.security.core.authority.AuthorityUtils;

@Getter
@Transient
public class ApiKeyAuthentication extends AbstractAuthenticationToken {

  @Serial private static final long serialVersionUID = -1137277407288808164L;

  private String apiKey;
  private ApiKeyAuthenticationDetails apiKeyAuthenticationDetails;

  public ApiKeyAuthentication(
      final String apiKey,
      final boolean authenticated,
      final ApiKeyAuthenticationDetails apiKeyAuthenticationDetails) {
    super(AuthorityUtils.NO_AUTHORITIES);
    this.apiKey = apiKey;
    this.apiKeyAuthenticationDetails = apiKeyAuthenticationDetails;
    this.setAuthenticated(authenticated);
  }

  public ApiKeyAuthentication(final String apiKey) {
    super(AuthorityUtils.NO_AUTHORITIES);
    this.apiKey = apiKey;
    this.setAuthenticated(false);
  }

  public ApiKeyAuthentication() {
    super(AuthorityUtils.NO_AUTHORITIES);
    this.setAuthenticated(false);
  }

  @Override
  public Object getCredentials() {
    return null;
  }

  @Override
  public Object getPrincipal() {
    return this.apiKey;
  }
}
