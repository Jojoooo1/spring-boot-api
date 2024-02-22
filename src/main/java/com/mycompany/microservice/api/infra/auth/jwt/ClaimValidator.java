package com.mycompany.microservice.api.infra.auth.jwt;

import com.mycompany.microservice.api.entities.Company;
import com.mycompany.microservice.api.services.CompanyService;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtClaimValidator;

@Slf4j
@Configuration(proxyBeanMethods = false)
@RequiredArgsConstructor
public class ClaimValidator {

  private final CompanyService companyService;

  /*
   * Prevent user without company to access the API
   * */
  @Bean
  OAuth2TokenValidator<Jwt> companySlugValidator() {
    return new JwtClaimValidator<String>(
        "company_slug",
        slug -> {
          final Optional<Company> companyOptional = this.companyService.findBySlugOptional(slug);
          if (companyOptional.isEmpty()) {
            log.warn("[companySlugValidator] company with slug {} not found", slug);
          }
          return companyOptional.isPresent();
        });
  }
}
