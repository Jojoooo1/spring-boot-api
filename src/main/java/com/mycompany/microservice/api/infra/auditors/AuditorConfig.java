package com.mycompany.microservice.api.infra.auditors;

import com.mycompany.microservice.api.facades.AuthFacade;
import java.util.Optional;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.lang.NonNull;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

@Configuration(proxyBeanMethods = false)
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class AuditorConfig {

  @Bean
  public AuditorAware<String> auditorProvider() {
    return new AuditorAwareImpl();
  }

  public static class AuditorAwareImpl implements AuditorAware<String> {

    @Override
    public @NonNull Optional<String> getCurrentAuditor() {

      return Optional.ofNullable(SecurityContextHolder.getContext())
          .map(SecurityContext::getAuthentication)
          .filter(Authentication::isAuthenticated)
          .flatMap(authentication -> AuthFacade.getUserEmailOptional());
    }
  }
}
