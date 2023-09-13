package com.mycompany.microservice.api.constants;

import lombok.experimental.UtilityClass;

@UtilityClass
public class AppHeaders {
  public static final String RESPONSE_TIME_HEADER = "Response-Time";
  public static final String API_KEY_HEADER = "Api-Key";
  public static final String TRACE_W3C_HEADER = "traceparent";

  public static final String MESSAGE_HEADER = "message";
}
