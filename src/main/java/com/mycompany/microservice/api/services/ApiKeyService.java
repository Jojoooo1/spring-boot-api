package com.mycompany.microservice.api.services;

import static com.mycompany.microservice.api.utils.CryptoUtils.randomKey;
import static java.lang.String.format;

import com.mycompany.microservice.api.entities.ApiKey;
import com.mycompany.microservice.api.exceptions.ResourceNotFoundException;
import com.mycompany.microservice.api.repositories.ApikeyRepository;
import com.mycompany.microservice.api.services.base.BaseService;
import java.util.Optional;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Transactional(readOnly = true)
@Service
@RequiredArgsConstructor
public class ApiKeyService extends BaseService<ApiKey> {
  @Getter private final ApikeyRepository repository;

  @Override
  protected void activitiesBeforeCreateEntity(final ApiKey entity) {
    entity.setIsActive(true);
    entity.setKey(randomKey(18));
  }

  public Optional<ApiKey> findByKeyOptional(final String key) {
    log.debug("[retrieving] apiKey");
    return this.repository.findByKeyAndIsActive(key, true);
  }

  public ApiKey findFirstByCompanyIdAndIsActive(final Long companyId) {
    log.debug("[retrieving] apiKey with companyId {}", companyId);
    return this.repository.findFirstByCompanyIdAndIsActive(companyId, true);
  }

  @Transactional
  public void inactivate(final Long id) {
    log.info("[inactivating] apiKey with id '{}'", id);

    final Optional<ApiKey> apiKeyOptional = this.getRepository().findById(id);
    if (apiKeyOptional.isEmpty()) {
      throw new ResourceNotFoundException(format("apiKey '%s' not found", id));
    }

    final ApiKey entity = apiKeyOptional.get();
    entity.setIsActive(false);
    this.update(entity);
  }
}
