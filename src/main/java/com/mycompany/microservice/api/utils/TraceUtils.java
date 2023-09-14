package com.mycompany.microservice.api.utils;

import static java.lang.String.format;

import io.micrometer.tracing.Span;
import io.micrometer.tracing.Tracer;
import lombok.experimental.UtilityClass;
import org.apache.commons.lang3.StringUtils;

@UtilityClass
public class TraceUtils {

  public static String getTrace(final Tracer tracer) {
    final Span span = tracer.currentSpan();
    if (span != null) {
      return span.context().traceId();
    } else {
      return StringUtils.EMPTY;
    }
  }

  public static String getSpan(final Tracer tracer) {
    final Span span = tracer.currentSpan();
    if (span != null) {
      return span.context().spanId();
    } else {
      return StringUtils.EMPTY;
    }
  }

  public static String getParentTrace(final Tracer tracer) {
    final Span span = tracer.currentSpan();
    if (span != null) {
      return format("00-%s-%s-00", span.context().traceId(), span.context().spanId());
    } else {
      return StringUtils.EMPTY;
    }
  }
}
