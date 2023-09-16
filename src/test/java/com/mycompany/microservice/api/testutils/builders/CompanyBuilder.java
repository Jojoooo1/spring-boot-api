package com.mycompany.microservice.api.testutils.builders;

import static com.mycompany.microservice.api.BaseIntegrationTest.random;

import com.mycompany.microservice.api.entities.Company;
import lombok.experimental.UtilityClass;

@UtilityClass
public class CompanyBuilder {

  public static Company company() {
    return Company.builder().name(random()).slug(random()).build();
  }

  public static Company platform() {
    return Company.builder().name(random()).slug(random()).isPlatform(true).build();
  }

  public static Company management() {
    return Company.builder().name(random()).slug(random()).isManagement(true).build();
  }

  public static Company internal() {
    return Company.builder().name(random()).slug(random()).isInternal(true).build();
  }
}
