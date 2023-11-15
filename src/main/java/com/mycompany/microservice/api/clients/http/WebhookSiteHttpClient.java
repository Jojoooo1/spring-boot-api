package com.mycompany.microservice.api.clients.http;

import static com.mycompany.microservice.api.clients.http.WebhookSiteUrlEnum.POST;
import static com.mycompany.microservice.api.utils.WebClientUtils.getErrorMessage;

import com.mycompany.microservice.api.utils.WebClientUtils;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Slf4j
@Getter
@Component
public class WebhookSiteHttpClient {

  private static final String NAME = "webhookSite";

  private final WebClient webClient;

  public WebhookSiteHttpClient(
      @Value("${http.clients.webhook-site.base-url}") final String baseUrl,
      @Value("${http.clients.default-timeout}") final Integer timeOutInMs,
      // Builder Bean is needed for Spring boot to autoconfigure tracing in HttpClient
      final WebClient.Builder builder) {
    this.webClient = WebClientUtils.createWebClient(builder, baseUrl, timeOutInMs, NAME);
  }

  public Mono<String> post(final Object request) {
    log.info("HTTP[{}] request {}", NAME, request);
    return this.getWebClient()
        .post()
        .uri(POST.getUrl())
        .bodyValue(request)
        .exchangeToMono(clientResponse -> clientResponse.bodyToMono(String.class))
        // Handle network exception (Timeout, SslClosedEngine, PrematureClose etc.)
        .onErrorResume(this::defaultErrorHandler);
  }

  private Mono<String> defaultErrorHandler(final Throwable ex) {
    log.warn("HTTP[{}}] errorInternal '{}'", NAME, getErrorMessage(ex), ex);
    return Mono.empty();
  }
}
