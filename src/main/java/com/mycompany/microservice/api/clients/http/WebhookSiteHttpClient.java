package com.mycompany.microservice.api.clients.http;

import static com.mycompany.microservice.api.clients.http.WebhookSiteUrlEnum.POST;
import static com.mycompany.microservice.api.utils.WebClientUtils.getErrorMessage;
import static java.lang.String.format;

import com.mycompany.microservice.api.utils.WebClientUtils;
import io.netty.handler.ssl.SslClosedEngineException;
import java.time.Duration;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.PrematureCloseException;
import reactor.util.retry.Retry;

@Slf4j
@Getter
@Component
public class WebhookSiteHttpClient {

  private static final String LOG_NAME = "webhookSite";

  private final WebClient webClient;

  public WebhookSiteHttpClient(
      @Value("${http.clients.my-external-api.base-url}") final String baseUrl,
      @Value("${http.clients.default-timeout}") final Integer timeOutInMs,
      // Builder is needed for Spring boot to autoconfigure trace
      final WebClient.Builder builder) {
    this.webClient = WebClientUtils.createWebClient(builder, baseUrl, timeOutInMs, null);
  }

  public Mono<String> post(final Object request) {
    log.debug(format("[%s][POST] url '%s'' request '%s'", LOG_NAME, POST, request));
    return this.getWebClient()
        .post()
        .uri(POST.getUrl())
        .bodyValue(request)
        // Those handler can also be set at service level for better granularity.
        .exchangeToMono(this::defaultResponseHandler)
        .retryWhen(this.defaultRetryHandler())
        .onErrorResume(this::defaultErrorHandler);
  }

  private Mono<String> defaultResponseHandler(final ClientResponse response) {
    final HttpStatusCode status = response.statusCode();

    return response
        // Does not enforce any class to keep http client generic.
        .bodyToMono(String.class)
        // Necessary to force mono execution on empty response.
        .defaultIfEmpty(StringUtils.EMPTY)
        .map(
            body -> {
              if (status.is2xxSuccessful()) {
                log.info("HTTP[RESPONSE] '{}'", body);
              } else {
                log.warn(format("HTTP[ERROR] status '%s' response '%s'", status, body));
                // Based on your needs you can throw an error and handle it with defaultErrorHandler
              }

              return body;
            });
  }

  private Mono<String> defaultErrorHandler(final Throwable ex) {
    log.warn("HTTP[ERROR_INTERNAL] '{}'", getErrorMessage(ex), ex);
    return Mono.empty();
  }

  /*
   * Error handler to improve network reliability.
   * */
  private Retry defaultRetryHandler() {
    return Retry.backoff(3, Duration.ofMillis(100))
        .filter(
            ex -> {
              if (ExceptionUtils.getRootCause(ex) instanceof PrematureCloseException) {
                log.info("HTTP[RETRY] PrematureCloseException detected retrying");
                return true;
              } else if (ExceptionUtils.getRootCause(ex) instanceof SslClosedEngineException) {
                log.info("HTTP[RETRY] SslClosedEngineException detected retrying");
                return true;
              }
              return false;
            });
  }
}
