package com.mycompany.microservice.api.constants;

import lombok.experimental.UtilityClass;

@UtilityClass
public final class AppConstants {
  public static final String API_DEFAULT_ERROR_MESSAGE =
      "Something went wrong. Please try again later or enter in contact with our service";

  public static final String SPAN_ID_LOG = "span_id";
  public static final String TRACE_ID_LOG = "trace_id";
}
