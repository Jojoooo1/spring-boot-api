package com.mycompany.microservice.api.requests.management;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record CreateApiKeyManagementRequest(@NotNull Long companyId, @NotBlank String name) {}
