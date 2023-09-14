package com.mycompany.microservice.api.infra.filters;

import com.mycompany.microservice.api.constants.AppUrls;
import com.mycompany.microservice.api.entities.Company;
import com.mycompany.microservice.api.facades.AuthFacade;
import com.mycompany.microservice.api.services.CompanyService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.Serial;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter(
    asyncSupported = true,
    urlPatterns = {AppUrls.INTERNAL + "/*"})
@RequiredArgsConstructor
public class InternalRequestFilter extends HttpFilter {

  @Serial private static final long serialVersionUID = 587106095561283733L;
  private static final String LOG_NAME = "InternalRequestFilter";

  final transient CompanyService companyService;

  @Override
  public void doFilter(
      final ServletRequest servletRequest,
      final ServletResponse servletResponse,
      final FilterChain filterChain) {
    log.debug("[{}] Verifying company exists and is_internal", LOG_NAME);

    final HttpServletRequest req = (HttpServletRequest) servletRequest;
    final HttpServletResponse res = (HttpServletResponse) servletResponse;

    try {

      final String companySlug = AuthFacade.getCompanySlug();
      final Optional<Company> companyOptional = this.companyService.findBySlugOptional(companySlug);

      if (companyOptional.isPresent()
          && Boolean.TRUE.equals(companyOptional.get().getIsInternal())) {
        log.debug("[{}] company '{}' is_internal authorized", LOG_NAME, companySlug);
        filterChain.doFilter(req, res);
      } else {
        log.info("[{}] company '{}' is_internal is false, returning 401", LOG_NAME, companySlug);
        res.reset();
        res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
      }
    } catch (final Exception exception) {
      log.error(exception.getMessage(), exception);
      res.reset();
      res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    }
  }
}
