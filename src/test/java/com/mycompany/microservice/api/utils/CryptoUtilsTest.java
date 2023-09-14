package com.mycompany.microservice.api.utils;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class CryptoUtilsTest {

  @Test
  void verifyRandomKey() {
    final int length = 10;
    Assertions.assertEquals(CryptoUtils.randomKey(length).length(), length * 2);
  }
}
