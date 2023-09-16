package com.mycompany.microservice.api.mappers;

import com.mycompany.microservice.api.entities.ApiKey;
import com.mycompany.microservice.api.mappers.base.ManagementBaseMapper;
import com.mycompany.microservice.api.requests.management.CreateApiKeyManagementRequest;
import com.mycompany.microservice.api.requests.management.UpdateApiKeyManagementRequest;
import com.mycompany.microservice.api.responses.management.ApikeyManagementResponse;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ApiKeyMapper
    extends ManagementBaseMapper<
        ApiKey,
        CreateApiKeyManagementRequest,
        UpdateApiKeyManagementRequest,
        ApikeyManagementResponse> {

  @Override
  ApiKey toEntity(CreateApiKeyManagementRequest request);

  @Override
  ApikeyManagementResponse toManagementResponse(ApiKey entity);
}
