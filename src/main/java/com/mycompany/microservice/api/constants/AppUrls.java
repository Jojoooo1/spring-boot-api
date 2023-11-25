package com.mycompany.microservice.api.constants;

import lombok.experimental.UtilityClass;

@UtilityClass
public class AppUrls {

  public static final String PLATFORM = "/platform";
  public static final String PLATFORM_API = PLATFORM + "/api";
  public static final String PLATFORM_MOBILE = PLATFORM + "/mobile";
  public static final String PLATFORM_WEB = PLATFORM + "/web";

  public static final String MANAGEMENT = "/management";
  public static final String INTERNAL = "/internal";

  public static final String BACK_OFFICE = "/back-office";

  public static final String PUBLIC = "/public";
}
