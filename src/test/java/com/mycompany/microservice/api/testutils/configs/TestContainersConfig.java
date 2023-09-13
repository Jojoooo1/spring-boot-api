// package com.mycompany.microservice.api.testutils.configs;
//
// import org.springframework.boot.test.context.TestConfiguration;
// import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
// import org.springframework.context.annotation.Bean;
// import org.testcontainers.containers.PostgreSQLContainer;
//
// @TestConfiguration(proxyBeanMethods = false)
// public class TestContainersConfig {
//
//  @Bean
//  @ServiceConnection
//  public PostgreSQLContainer<?> postgresContainer() {
//    return new PostgreSQLContainer<>("bitnami/postgresql:15.4.0-debian-11-r21").withReuse(true);
//  }
// }
