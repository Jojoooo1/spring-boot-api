package com.mycompany.microservice.api.infra.executors;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.core.task.TaskExecutor;
import org.springframework.core.task.support.ContextPropagatingTaskDecorator;

@Configuration(proxyBeanMethods = false)
public class TaskExecutorConfig {

  /*
   * Override default SimpleAsyncTaskExecutor to provide context propagation in @Async function
   * */
  @Bean
  public TaskExecutor simpleAsyncTaskExecutor() {
    final SimpleAsyncTaskExecutor taskExecutor = new SimpleAsyncTaskExecutor();
    taskExecutor.setTaskDecorator(new ContextPropagatingTaskDecorator());
    return taskExecutor;
  }
}
