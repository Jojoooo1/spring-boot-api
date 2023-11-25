package com.mycompany.microservice.api.services.base;

import static com.mycompany.microservice.api.listeners.EntityTransactionLogListener.EntityTransactionLogEvent.EntityTransactionLogEnum.CREATE;
import static com.mycompany.microservice.api.listeners.EntityTransactionLogListener.EntityTransactionLogEvent.EntityTransactionLogEnum.DELETE;
import static com.mycompany.microservice.api.listeners.EntityTransactionLogListener.EntityTransactionLogEvent.EntityTransactionLogEnum.UPDATE;
import static com.mycompany.microservice.api.services.base.BaseService.ServiceOperation.CREATING;
import static com.mycompany.microservice.api.services.base.BaseService.ServiceOperation.DELETING;
import static com.mycompany.microservice.api.services.base.BaseService.ServiceOperation.UPDATING;
import static java.lang.String.format;
import static org.apache.commons.collections4.CollectionUtils.isEmpty;

import com.mycompany.microservice.api.entities.base.BaseEntity;
import com.mycompany.microservice.api.exceptions.ResourceNotFoundException;
import com.mycompany.microservice.api.listeners.EntityTransactionLogListener.EntityTransactionLogEvent;
import jakarta.persistence.Table;
import java.lang.reflect.ParameterizedType;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.NonNull;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Transactional(readOnly = true)
public abstract class BaseService<E extends BaseEntity> {

  private static final int ENTITY_MAX_SIZE_TO_LOG = 100;

  @Autowired private ApplicationEventPublisher applicationEventPublisher;

  public abstract JpaRepository<E, Long> getRepository();

  public E findById(final Long id) {
    log.debug("[retrieving] {} {}", this.getEntityName(), id);
    return this.getRepository().findById(id).orElseThrow(() -> new ResourceNotFoundException(id));
  }

  public Optional<E> findByIdOptional(final Long id) {
    log.debug("[retrieving] {} {}", this.getEntityName(), id);
    return this.getRepository().findById(id);
  }

  public List<E> findAll() {
    log.debug("[retrieving] all {}", this.getEntityName());
    return this.getRepository().findAll();
  }

  public Page<E> findAll(final Pageable pageable) {
    log.debug("[retrieving] all {}", this.getEntityName());
    return this.getRepository().findAll(pageable);
  }

  @Transactional
  public E create(final E entity) {
    return this.createAll(List.of(entity)).getFirst();
  }

  @Transactional
  public List<E> createAll(final List<E> entities) {
    return this.createAll(entities, false);
  }

  @Transactional
  public List<E> createAll(final List<E> entities, final boolean skipActivities) {
    return this.saveAll(entities, skipActivities, CREATING);
  }

  @Transactional
  public E update(final E entity) {
    return this.updateAll(List.of(entity)).getFirst();
  }

  @Transactional
  public List<E> updateAll(final List<E> entities) {
    return this.updateAll(entities, false);
  }

  @Transactional
  public List<E> updateAll(final List<E> entities, final boolean skipActivities) {
    return this.saveAll(entities, skipActivities, UPDATING);
  }

  @Transactional
  public List<E> saveAll(
      @NonNull final List<E> entities,
      final boolean skipActivities,
      final ServiceOperation operation) {

    if (isEmpty(entities)) {
      log.info("[{}] empty entities, returning.", operation.getName());
      return Collections.emptyList();
    }

    switch (operation) {
      case CREATING -> {
        if (entities.stream()
            .map(entity -> entity.getId() != null)
            .toList()
            .contains(Boolean.TRUE)) {
          throw new IllegalStateException(
              "Some entities already have an id. Are you trying to create an existing entity?");
        }
      }
      case UPDATING -> {
        if (entities.stream()
            .map(entity -> entity.getId() == null)
            .toList()
            .contains(Boolean.TRUE)) {
          throw new IllegalStateException(
              "Some entities does not have id. Are you trying to update a new entity?");
        }
      }
      default -> throw new IllegalStateException("ServiceOperation not found");
    }

    log.info(
        "[{}] {} {}", operation.getName(), this.getEntityName(), this.getEntitiesToLog(entities));

    if (!skipActivities) {
      switch (operation) {
        case CREATING -> this.activitiesBeforeCreateEntities(entities);
        case UPDATING -> this.activitiesBeforeUpdateEntities(entities);
        default -> throw new IllegalStateException("ServiceOperation not found");
      }
    }

    // Used to improve cache management since saveAll will reset the entire cache.
    if (entities.size() == 1) {
      this.getRepository().save(entities.getFirst());
    } else {
      this.getRepository().saveAll(entities);
    }

    if (!skipActivities) {
      switch (operation) {
        case CREATING -> this.activitiesAfterCreateEntities(entities);
        case UPDATING -> this.activitiesAfterUpdateEntities(entities);
        default -> throw new IllegalStateException("ServiceOperation not found");
      }
    }

    this.applicationEventPublisher.publishEvent(
        new EntityTransactionLogEvent(
            switch (operation) {
              case CREATING -> CREATE;
              case UPDATING -> UPDATE;
              default -> throw new IllegalStateException("ServiceOperation not found");
            },
            this.getEntityName(),
            this.getEventEntitiesToLog(entities)));

    return entities;
  }

  @Transactional
  public void delete(final Long id) {
    this.delete(this.findById(id));
  }

  @Transactional
  public void delete(final E entity) {
    this.deleteAll(List.of(entity), false);
  }

  @Transactional
  public void deleteAll(final List<E> entities, final boolean skipActivities) {

    if (isEmpty(entities)) {
      log.info("[{}] empty entities, returning.", DELETING.getName());
      return;
    }

    final List<Long> ids =
        entities.stream().map(BaseEntity::getId).filter(Objects::nonNull).toList();
    if (entities.size() != ids.size()) {
      throw new IllegalStateException(
          "Some entities does not have id. Are you trying to delete a new entity?");
    }

    log.info(
        "[{}] {} {}", DELETING.getName(), this.getEntityName(), this.getEntitiesToLog(entities));

    if (!skipActivities) {
      this.activitiesBeforeDeleteEntities(entities);
    }

    // Used to improve cache management since deleteAll will reset the entire cache.
    if (entities.size() == 1) {
      this.getRepository().delete(entities.getFirst());
    } else {
      this.getRepository().deleteAll(entities);
    }

    if (!skipActivities) {
      this.activitiesAfterDeleteEntities(ids);
    }

    this.applicationEventPublisher.publishEvent(
        new EntityTransactionLogEvent(
            DELETE, this.getEntityName(), this.getEventEntitiesToLog(entities)));
  }

  /*
   * Create activities
   * */
  protected void activitiesBeforeCreateEntity(final E entity) {}

  protected void activitiesBeforeCreateEntities(final List<E> entities) {
    entities.forEach(this::activitiesBeforeCreateEntity);
  }

  protected void activitiesAfterCreateEntity(final E entity) {}

  protected final void activitiesAfterCreateEntities(final List<E> entities) {
    entities.forEach(this::activitiesAfterCreateEntity);
  }

  /*
   * Update activities
   * */
  protected void activitiesBeforeUpdateEntity(final E entity) {}

  protected void activitiesBeforeUpdateEntities(final List<E> entities) {
    entities.forEach(this::activitiesBeforeUpdateEntity);
  }

  protected void activitiesAfterUpdateEntity(final E entity) {}

  protected void activitiesAfterUpdateEntities(final List<E> entities) {
    entities.forEach(this::activitiesAfterUpdateEntity);
  }

  /*
   * Delete activities
   * */
  protected void activitiesBeforeDeleteEntity(final E entity) {}

  protected void activitiesBeforeDeleteEntities(final List<E> entities) {
    entities.forEach(this::activitiesBeforeDeleteEntity);
  }

  protected void activitiesAfterDeleteEntity(final Long id) {}

  protected void activitiesAfterDeleteEntities(final List<Long> ids) {
    ids.forEach(this::activitiesAfterDeleteEntity);
  }

  private String getEntityName() {
    final Class<E> entityModelClass =
        (Class<E>)
            ((ParameterizedType) this.getClass().getGenericSuperclass())
                .getActualTypeArguments()[0];
    final Table annotation = entityModelClass.getAnnotation(Table.class);
    return annotation.name();
  }

  private String getEntitiesToLog(final List<E> entities) {
    return entities.size() < ENTITY_MAX_SIZE_TO_LOG
        ? entities.toString()
        : format("with '%s' entities", entities.size());
  }

  private String getEventEntitiesToLog(final List<E> entities) {
    return entities.size() < ENTITY_MAX_SIZE_TO_LOG
        ? entities.stream().map(e -> e.getId().toString()).toList().toString()
        : format("with '%s' entities", entities.size());
  }

  @Getter
  @AllArgsConstructor(access = AccessLevel.PRIVATE)
  public enum ServiceOperation {
    CREATING("creating"),
    UPDATING("updating"),
    DELETING("deleting");

    private final String name;
  }
}
