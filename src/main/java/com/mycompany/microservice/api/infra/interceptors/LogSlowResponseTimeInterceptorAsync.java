package com.mycompany.microservice.api.infra.interceptors;

import static com.mycompany.microservice.api.utils.TimeUtils.ONE_MILLI;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

@Slf4j
@RequiredArgsConstructor
public class LogSlowResponseTimeInterceptorAsync implements AsyncHandlerInterceptor {

  private static final String EXEC_TIME_ASYNC = "execTimeAsync";
  private final int maxResponseTimeToLogInMs;

  @Override
  public void afterConcurrentHandlingStarted(
      final HttpServletRequest request,
      @NonNull final HttpServletResponse response,
      @NonNull final Object handler) {
    final Long startTime = (Long) request.getAttribute(EXEC_TIME_ASYNC);
    if (startTime != null) {
      final long elapsedInNanoS = System.nanoTime() - startTime;
      final long responseTimeInMs = elapsedInNanoS / ONE_MILLI;
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
