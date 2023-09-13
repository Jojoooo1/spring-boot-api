package com.mycompany.microservice.api.mappers;

import com.mycompany.microservice.api.entities.Company;
import com.mycompany.microservice.api.mappers.base.ManagementBaseMapper;
import com.mycompany.microservice.api.requests.management.CreateCompanyManagementRequest;
import com.mycompany.microservice.api.requests.management.UpdateCompanyManagementRequest;
import com.mycompany.microservice.api.responses.management.CompanyManagementResponse;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CompanyMapper
    extends ManagementBaseMapper<
        Company,
        CreateCompanyManagementRequest,
        UpdateCompanyManagementRequest,
        CompanyManagementResponse> {}
