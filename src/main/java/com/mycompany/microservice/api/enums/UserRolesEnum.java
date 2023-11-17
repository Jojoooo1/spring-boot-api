package com.mycompany.microservice.api.enums;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum UserRolesEnum {
  PLATFORM_USER("platform_user"),
  PLATFORM_ADMIN("platform_admin"),
  PLATFORM_API_USER("platform_api_user"), // Set from company.is_platform

  BACK_OFFICE_USER("back_office_user"),
  BACK_OFFICE_ADMIN("back_office_admin"),

  MANAGEMENT_USER("management_user"),
  MANAGEMENT_ADMIN("management_admin"),

  INTERNAL_API_USER("internal_api_user"); // Set from company.is_internal

  private final String name;
}
