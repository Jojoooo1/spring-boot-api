package com.mycompany.microservice.api.utils;

import lombok.experimental.UtilityClass;

@UtilityClass
public class StringUtils {

  public static String numericOnly(final String value) {

    if (org.apache.commons.lang3.StringUtils.isBlank(value)) {
      return value;
    }

    return value.replaceAll("\\D", "");
  }
}
