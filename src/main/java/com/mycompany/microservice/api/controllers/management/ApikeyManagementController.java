package com.mycompany.microservice.api.controllers.management;

import com.mycompany.microservice.api.constants.AppUrls;
import com.mycompany.microservice.api.controllers.management.base.BaseManagementController;
import com.mycompany.microservice.api.entities.ApiKey;
import com.mycompany.microservice.api.mappers.ApiKeyMapper;
import com.mycompany.microservice.api.requests.management.CreateApiKeyManagementRequest;
import com.mycompany.microservice.api.requests.management.UpdateApiKeyManagementRequest;
import com.mycompany.microservice.api.responses.management.ApikeyManagementResponse;
import com.mycompany.microservice.api.services.ApiKeyService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping(ApikeyManagementController.BASE_URL)
@RequiredArgsConstructor
public class ApikeyManagementController
    extends BaseManagementController<
        ApiKey,
        CreateApiKeyManagementRequest,
        UpdateApiKeyManagementRequest,
        ApikeyManagementResponse> {
  public static final String BASE_URL = AppUrls.MANAGEMENT + "/api-keys";

  @Getter private final ApiKeyService service;
  @Getter private final ApiKeyMapper mapper;

  @ResponseStatus(HttpStatus.NO_CONTENT)
  @DeleteMapping("/{id}")
  @Override
  public void delete(@PathVariable("id") final Long id) {
    log.info("[request] inactive {} '{}'", ApiKey.TABLE_NAME, id);
    this.service.inactivate(id);
  }
}
