package com.mycompany.microservice.api.infra.interceptors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.HandlerInterceptor;

public class TimeExecutionInterceptor implements HandlerInterceptor {

  private static final String TIME = "StopWatch";

  @Override
  public boolean preHandle(
      final HttpServletRequest request,
      @NonNull final HttpServletResponse response,
      @NonNull final Object handler) {
    final long nano = System.nanoTime();

    request.setAttribute(TIME, nano);
    return true;
  }
}
