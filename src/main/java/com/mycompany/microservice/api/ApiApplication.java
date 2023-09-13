package com.mycompany.microservice.api;

import jakarta.annotation.PostConstruct;
import java.util.TimeZone;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import reactor.core.publisher.Hooks;

@ServletComponentScan
@EnableCaching
@SpringBootApplication
public class ApiApplication {

  public static void main(final String[] args) {
    SpringApplication.run(ApiApplication.class, args);
  }

  @PostConstruct
  void started() {
    TimeZone.setDefault(TimeZone.getTimeZone("America/Sao_Paulo"));
    Hooks.enableAutomaticContextPropagation();
  }
}
