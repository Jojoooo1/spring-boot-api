package com.mycompany.microservice.api.listeners;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

/*
 * EntityTransactionLogListener:
 *
 * Log transaction event for all entities after they were committed/rollback
 * ex: [created] company [16]
 *
 */
@Slf4j
@Component
public class EntityTransactionLogListener {

  @Async
  @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
  public void onCommitEvent(final EntityTransactionLogEvent event) {
    log.info("[{}] {} {}", event.operation().getName(), event.entityName(), event.entitiesToLog());
  }

  @Async
  @TransactionalEventListener(phase = TransactionPhase.AFTER_ROLLBACK)
  public void onRollbackEvent(final EntityTransactionLogEvent event) {
    log.info(
        "[{}] {} {} rollback.",
        event.operation().getName(),
        event.entityName(),
        event.entitiesToLog());
  }

  public record EntityTransactionLogEvent(
      EntityTransactionLogEnum operation, String entityName, String entitiesToLog) {

    @Getter
    @AllArgsConstructor(access = AccessLevel.PRIVATE)
    public enum EntityTransactionLogEnum {
      CREATE("created"),
      UPDATE("updated"),
      DELETE("deleted"),
      UNKNOWN("unknown");

      private final String name;
    }
  }
}
