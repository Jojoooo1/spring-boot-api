package com.mycompany.microservice.api.utils;

import com.mycompany.microservice.api.entities.Company;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class JsonUtilsTest {

  @Test
  void verifyDeserializeFromCamelCase() {
    final Company company =
        JsonUtils.deserializeFromCamelCase("{\"officialName\": \"test\"}", Company.class);
    Assertions.assertTrue(StringUtils.isNotEmpty(company.getOfficialName()));
  }

  @Test
  void verifyDeserializeFromSnakeCase() {
    final Company company =
        JsonUtils.deserializeFromSnakeCase("{\"official_name\": \"test\"}", Company.class);
    Assertions.assertTrue(StringUtils.isNotEmpty(company.getOfficialName()));
  }

  @Test
  void verifySerializeToCamelCase() {
    final String json = JsonUtils.serializeToCamelCase(new Company());
    Assertions.assertTrue(json.contains("officialName"));
  }

  @Test
  void verifySerializeToSnakeCase() {
    final String json = JsonUtils.serializeToSnakeCase(new Company());
    Assertions.assertTrue(json.contains("official_name"));
  }
}
