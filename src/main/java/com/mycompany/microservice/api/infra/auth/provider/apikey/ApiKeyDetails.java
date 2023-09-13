package com.mycompany.microservice.api.infra.auth.provider.apikey;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiKeyDetails {
  private Long id;
  private String email;
  private String companySlug;
}
