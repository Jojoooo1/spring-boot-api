package com.mycompany.microservice.api.infra.otlp;

import io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter;
import io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporterBuilder;
import java.util.Map.Entry;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.actuate.autoconfigure.tracing.otlp.OtlpProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// Not working yet, need to wait for spring boot to be compatible with otel exporter 1.34.

@Configuration(proxyBeanMethods = false)
@EnableConfigurationProperties(OtlpProperties.class)
public class OtlpConfiguration {

  // For some reason breaking change was introduced, and we need to pass a default value
  private static final String OTLP_DEFAULT = "http://localhost:4318/api/traces";

  // OtlpAutoConfiguration use HTTP by default, we update it to use GRPC
  // https://github.com/spring-projects/spring-boot/blob/main/spring-boot-project/spring-boot-actuator-autoconfigure/src/main/java/org/springframework/boot/actuate/autoconfigure/tracing/otlp/OtlpAutoConfiguration.java
  @Bean
  public OtlpGrpcSpanExporter otlpExporter(final OtlpProperties properties) {

    final OtlpGrpcSpanExporterBuilder builder =
        OtlpGrpcSpanExporter.builder()
            .setEndpoint(
                StringUtils.isNotBlank(properties.getEndpoint())
                    ? properties.getEndpoint()
                    : OTLP_DEFAULT)
            .setTimeout(properties.getTimeout())
            .setCompression(String.valueOf(properties.getCompression()).toLowerCase());

    for (final Entry<String, String> header : properties.getHeaders().entrySet()) {
      builder.addHeader(header.getKey(), header.getValue());
    }

    return builder.build();
  }
}
