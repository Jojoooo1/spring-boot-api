package com.mycompany.microservice.api.enums;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum UserRolesEnum {
  MOBILE_USER("mobile_user"),
  MOBILE_ADMIN("mobile_admin"),
  BACK_OFFICE_USER("back_office_user"),
  BACK_OFFICE_ADMIN("back_office_admin");

  private final String slug;
}
