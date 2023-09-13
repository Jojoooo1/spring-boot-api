package com.mycompany.microservice.api.controllers.management;

import com.mycompany.microservice.api.constants.AppUrls;
import com.mycompany.microservice.api.controllers.management.base.BaseManagementController;
import com.mycompany.microservice.api.entities.Company;
import com.mycompany.microservice.api.mappers.CompanyMapper;
import com.mycompany.microservice.api.requests.management.CreateCompanyManagementRequest;
import com.mycompany.microservice.api.requests.management.UpdateCompanyManagementRequest;
import com.mycompany.microservice.api.responses.management.CompanyManagementResponse;
import com.mycompany.microservice.api.services.CompanyService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping(CompanyManagementController.BASE_URL)
@RequiredArgsConstructor
public class CompanyManagementController
    extends BaseManagementController<
        Company,
        CreateCompanyManagementRequest,
        UpdateCompanyManagementRequest,
        CompanyManagementResponse> {

  public static final String BASE_URL = AppUrls.MANAGEMENT + "/companies";

  @Getter private final CompanyService service;
  @Getter private final CompanyMapper mapper;
}
