package com.mycompany.microservice.api.testutils.builders;

import static com.mycompany.microservice.api.BaseIntegrationTest.random;

import com.mycompany.microservice.api.entities.ApiKey;
import com.mycompany.microservice.api.entities.Company;
import lombok.experimental.UtilityClass;

@UtilityClass
public class ApiKeyBuilder {
  public static ApiKey apiKey(final Company company) {
    return ApiKey.builder().name(random()).companyId(company.getId()).build();
  }
}
