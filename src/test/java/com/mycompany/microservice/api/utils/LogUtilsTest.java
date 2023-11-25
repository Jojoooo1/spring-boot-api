package com.mycompany.microservice.api.utils;

import static org.apache.commons.lang3.StringUtils.EMPTY;

import com.mycompany.microservice.api.entities.Company;
import java.util.List;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class LogUtilsTest {

  @Test
  void verifyLogIdNullSafe() {
    Assertions.assertEquals(EMPTY, LogUtils.logId(null));
    Assertions.assertEquals(EMPTY, LogUtils.logId(new Company()));
  }

  @Test
  void verifyLogId() {
    final var company = new Company(1L);
    Assertions.assertEquals(LogUtils.logId(company), company.getId().toString());
  }

  @Test
  void verifyLogIdsNullSafe() {
    Assertions.assertEquals(LogUtils.logIds(null), List.of().toString());
    Assertions.assertEquals(LogUtils.logIds(List.of()), List.of().toString());
  }

  @Test
  void verifyLogIds() {
    final var company = new Company(1L);
    Assertions.assertEquals(LogUtils.logIds(List.of(company)), List.of(company.getId()).toString());
  }
}
