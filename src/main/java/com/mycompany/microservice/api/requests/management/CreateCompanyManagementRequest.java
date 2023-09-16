package com.mycompany.microservice.api.requests.management;

import jakarta.validation.constraints.NotBlank;
import java.math.BigDecimal;

public record CreateCompanyManagementRequest(
    @NotBlank String slug,
    @NotBlank String name,
    String officialName,
    String federalTaxId,
    String stateTaxId,
    String phone,
    String email,
    String addressStreet,
    String addressStreetNumber,
    String addressComplement,
    String addressCityDistrict,
    String addressPostCode,
    String addressCity,
    String addressStateCode,
    String addressCountry,
    BigDecimal addressLatitude,
    BigDecimal addressLongitude,
    Boolean isManagement,
    Boolean isInternal,
    Boolean isPlatform) {}
