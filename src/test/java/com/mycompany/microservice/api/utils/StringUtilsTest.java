package com.mycompany.microservice.api.utils;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class StringUtilsTest {
  @Test
  void verifyNumericOnly() {
    final var numericValue = "1234567890";
    final String string = numericValue + "zertygsdfghjklm";
    Assertions.assertEquals(StringUtils.numericOnly(string), numericValue);
  }
}
