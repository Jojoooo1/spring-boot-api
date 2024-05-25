package com.mycompany.microservice.api.rabbitmq.configs;

import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.AcknowledgeMode;
import org.springframework.amqp.rabbit.config.DirectRabbitListenerContainerFactory;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.retry.support.RetryTemplate;

@Slf4j
@Configuration(proxyBeanMethods = false)
public class RabbitConfig {

  public static final String RABBIT_ASYNC_EVENT_LISTENER_FACTORY = "AsyncEventListener";
  public static final String RABBIT_EVENT_PUBLISHER = "EventPublisher";

  @Value("${rabbitmq.host}")
  private String host;

  @Value("${rabbitmq.port}")
  private int port;

  @Value("${rabbitmq.username}")
  private String username;

  @Value("${rabbitmq.password}")
  private String password;

  @Value("${rabbitmq.listeners.event.prefetch-count}")
  private Integer prefetchCount;

  private ConnectionFactory connectionFactory(final String connectionName) {
    final CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
    connectionFactory.setConnectionNameStrategy(conn -> connectionName);

    connectionFactory.setHost(this.host);
    connectionFactory.setPort(this.port);
    connectionFactory.setUsername(this.username);
    connectionFactory.setPassword(this.password);

    return connectionFactory;
  }

  @Bean(name = RABBIT_ASYNC_EVENT_LISTENER_FACTORY)
  public DirectRabbitListenerContainerFactory eventListenerFactory() {
    final DirectRabbitListenerContainerFactory factory = new DirectRabbitListenerContainerFactory();
    factory.setConnectionFactory(this.connectionFactory("api-event-listener"));
    factory.setMessageConverter(new Jackson2JsonMessageConverter());
    factory.setObservationEnabled(true);
    factory.setAutoStartup(false); // started at ApplicationReadyEvent

    // https://docs.spring.io/spring-amqp/docs/current/reference/html/#async-listeners
    factory.setAcknowledgeMode(AcknowledgeMode.MANUAL);
    factory.setDefaultRequeueRejected(false);
    factory.setPrefetchCount(this.prefetchCount);
    return factory;
  }

  @Bean(name = RABBIT_EVENT_PUBLISHER)
  public RabbitTemplate rabbitTemplate() {
    final RabbitTemplate factory =
        new RabbitTemplate(this.connectionFactory("api-event-publisher"));
    factory.setMessageConverter(new Jackson2JsonMessageConverter());
    factory.setObservationEnabled(true);
    factory.setRetryTemplate(RetryTemplate.defaultInstance());

    return factory;
  }
}
