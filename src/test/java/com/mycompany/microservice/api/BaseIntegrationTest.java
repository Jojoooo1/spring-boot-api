package com.mycompany.microservice.api;

import java.nio.file.Paths;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestInstance.Lifecycle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.RabbitMQContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.lifecycle.Startables;
import org.testcontainers.utility.MountableFile;

@ActiveProfiles("test")
@AutoConfigureMockMvc
@TestInstance(Lifecycle.PER_CLASS)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public abstract class BaseIntegrationTest {

  @Container @ServiceConnection
  public static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:15-alpine");

  @Container public static RabbitMQContainer rabbit = new RabbitMQContainer("rabbitmq:3.12.9");

  static {
    setRabbitConfig(rabbit);
    Startables.deepStart(postgres, rabbit).join();
  }

  @Autowired public MockMvc mockMvc;

  @DynamicPropertySource
  static void applicationProperties(final DynamicPropertyRegistry registry) {
    registry.add("rabbitmq.host", rabbit::getHost);
    registry.add("rabbitmq.port", rabbit::getAmqpPort);
    // defined in resources/testcontainers/rabbitmq-definition.json
    registry.add("rabbitmq.username", () -> "user");
    registry.add("rabbitmq.password", () -> "password");
  }

  public static String random(final Integer... args) {
    return RandomStringUtils.randomAlphabetic(args.length == 0 ? 10 : args[0]);
  }

  public static String randomNumeric(final Integer... args) {
    return RandomStringUtils.randomNumeric(args.length == 0 ? 10 : args[0]);
  }

  private static String getResourcesDir() {
    return Paths.get("src", "test", "resources").toFile().getAbsolutePath();
  }

  private static String getRabbitDefinition() {
    return getResourcesDir() + "/testcontainers/rabbitmq-definition.json";
  }

  private static String getRabbitConfig() {
    return getResourcesDir() + "/testcontainers/rabbitmq.conf";
  }

  private static void setRabbitConfig(final RabbitMQContainer rabbit) {
    rabbit.withCopyFileToContainer(
        MountableFile.forHostPath(getRabbitDefinition()), "/etc/rabbitmq/definitions.json");
    rabbit.withCopyFileToContainer(
        MountableFile.forHostPath(getRabbitConfig()), "/etc/rabbitmq/rabbitmq.conf");
  }
}
