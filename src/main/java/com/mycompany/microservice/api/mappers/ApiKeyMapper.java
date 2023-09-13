package com.mycompany.microservice.api.mappers;

import com.mycompany.microservice.api.entities.ApiKey;
import com.mycompany.microservice.api.mappers.base.ManagementBaseMapper;
import com.mycompany.microservice.api.requests.management.CreateApiKeyManagementRequest;
import com.mycompany.microservice.api.requests.management.UpdateApiKeyManagementRequest;
import com.mycompany.microservice.api.responses.management.ApikeyManagementResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ApiKeyMapper
    extends ManagementBaseMapper<
        ApiKey,
        CreateApiKeyManagementRequest,
        UpdateApiKeyManagementRequest,
        ApikeyManagementResponse> {

  @Mapping(
      target = "company",
      expression = "java(request.companyId() == null ? null : new Company(request.companyId()))")
  @Override
  ApiKey toEntity(CreateApiKeyManagementRequest request);

  @Mapping(source = "company.id", target = "companyId")
  @Override
  ApikeyManagementResponse toManagementResponse(ApiKey entity);
}
