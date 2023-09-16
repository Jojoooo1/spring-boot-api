package com.mycompany.microservice.api.controllers.platform.api;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.mycompany.microservice.api.BaseIntegrationTest;
import com.mycompany.microservice.api.constants.AppHeaders;
import com.mycompany.microservice.api.services.ApiKeyService;
import com.mycompany.microservice.api.services.CompanyService;
import com.mycompany.microservice.api.testutils.builders.ApiKeyBuilder;
import com.mycompany.microservice.api.testutils.builders.CompanyBuilder;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

class AuthorizationPlatformApiControllerIT extends BaseIntegrationTest {

  private static final String URL = PlatformApiController.BASE_URL + "/hello-world";

  @Autowired private ApiKeyService apiKeyService;
  @Autowired private CompanyService companyService;

  @BeforeAll
  void init() {}

  @Test
  void return_401_IfApikeyIsNotFound() throws Exception {
    this.mockMvc
        .perform(get(URL).header(AppHeaders.API_KEY_HEADER, random()))
        .andExpect(status().isUnauthorized());
  }

  @Test
  void return_401_IfApikeyCompanyHasWrongRole() throws Exception {
    final var company = this.companyService.create(CompanyBuilder.company());
    final var apiKey = this.apiKeyService.create(ApiKeyBuilder.apiKey(company));
    this.mockMvc
        .perform(delete(URL).header(AppHeaders.API_KEY_HEADER, apiKey.getKey()))
        .andExpect(status().isForbidden());

    final var management = this.companyService.create(CompanyBuilder.management());
    final var apiKeyManagement = this.apiKeyService.create(ApiKeyBuilder.apiKey(management));
    this.mockMvc
        .perform(delete(URL).header(AppHeaders.API_KEY_HEADER, apiKeyManagement.getKey()))
        .andExpect(status().isForbidden());
  }

  @Test
  void return_401_IfApikeyIsDisabled() throws Exception {
    final var platform = this.companyService.create(CompanyBuilder.platform());
    final var apiKey = this.apiKeyService.create(ApiKeyBuilder.apiKey(platform));
    this.apiKeyService.delete(apiKey.getId());
    this.mockMvc
        .perform(get(URL).header(AppHeaders.API_KEY_HEADER, apiKey.getKey()))
        .andExpect(status().isUnauthorized());
  }

  @Test
  void return_200() throws Exception {
    final var platform = this.companyService.create(CompanyBuilder.platform());
    final var apiKey = this.apiKeyService.create(ApiKeyBuilder.apiKey(platform));
    this.mockMvc
        .perform(get(URL).header(AppHeaders.API_KEY_HEADER, apiKey.getKey()))
        .andExpect(status().isOk());
  }
}
