package com.mycompany.microservice.api.infra.filters;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

/*
 * This filter is used to inject nginx trace value
 * within MDC context.
 */
@Component
public class AddNginxReqIdToMDCFilter extends OncePerRequestFilter {

  private static final String NGINX_REQUEST_ID_HEADER = "X-Request-ID";

  @Override
  protected void doFilterInternal(
      final @NonNull HttpServletRequest request,
      final @NonNull HttpServletResponse response,
      final FilterChain filterChain)
      throws ServletException, IOException {

    final String nginxRequestId = request.getHeader(NGINX_REQUEST_ID_HEADER);

    MDC.put(
        NGINX_REQUEST_ID_HEADER,
        StringUtils.isNotBlank(nginxRequestId) ? nginxRequestId : StringUtils.EMPTY);

    try {
      filterChain.doFilter(request, response);
    } finally {
      MDC.remove(NGINX_REQUEST_ID_HEADER);
    }
  }

  @Override
  protected boolean shouldNotFilterAsyncDispatch() {
    return false;
  }

  @Override
  protected boolean shouldNotFilterErrorDispatch() {
    return false;
  }
}
