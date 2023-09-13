package com.mycompany.microservice.api.constants;

import lombok.experimental.UtilityClass;

@UtilityClass
public class AppUrls {

  /*
   * API Protected by API Key
   * */
  public static final String API = "/api";
  public static final String API_V1 = API + "/v1";
  public static final String MANAGEMENT = "/management";
  public static final String INTERNAL = "/internal";

  /*
   * Applications protected by JWT roles
   * */
  public static final String MOBILE_APP = "/mobile";
  public static final String BACK_OFFICE_APP = "/back-office";

  /*
   * Public
   * */
  public static final String PUBLIC = "/public";
}
