package com.mycompany.microservice.api.infra.interceptors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
public class LogSlowResponseTimeInterceptor implements HandlerInterceptor {

  private static final String EXEC_TIME = "execTime";
  private final int maxResponseTimeToLogInMs;

  public LogSlowResponseTimeInterceptor(final int maxResponseTimeToLogInMs) {
    this.maxResponseTimeToLogInMs = maxResponseTimeToLogInMs;
  }

  @Override
  public boolean preHandle(
      final HttpServletRequest request,
      final @NonNull HttpServletResponse response,
      final @NonNull Object handler) {
    request.setAttribute(EXEC_TIME, System.nanoTime());
    return true;
  }

  @Override
  public void postHandle(
      final HttpServletRequest request,
      final @NonNull HttpServletResponse response,
      final @NonNull Object handler,
      final ModelAndView modelAndView) {
    final Long startTime = (Long) request.getAttribute(EXEC_TIME);
    if (startTime != null) {
      final long elapsedInNanoS = System.nanoTime() - startTime;
      final long responseTimeInMs = elapsedInNanoS / 1_000_000;
      if (responseTimeInMs > this.maxResponseTimeToLogInMs) {
        log.warn(
            "[SLOW_REQUEST] {}ms {} '{}'",
            responseTimeInMs,
            request.getMethod(),
            request.getRequestURI());
      }
    }
  }
}
