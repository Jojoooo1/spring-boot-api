package com.mycompany.microservice.api.clients.http;

import static com.mycompany.microservice.api.clients.http.WebhookSiteUrlEnum.POST;
import static com.mycompany.microservice.api.utils.WebClientUtils.getErrorMessage;

import com.mycompany.microservice.api.utils.WebClientUtils;
import io.github.resilience4j.circuitbreaker.CircuitBreaker;
import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig;
import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig.SlidingWindowType;
import io.github.resilience4j.reactor.circuitbreaker.operator.CircuitBreakerOperator;
import java.time.Duration;
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
  private final CircuitBreaker defaultCircuitBreaker;

  public WebhookSiteHttpClient(
      @Value("${http.clients.webhook-site.base-url}") final String baseUrl,
      @Value("${http.clients.default-timeout}") final Integer timeOutInMs,
      // Builder Bean is needed for Spring boot to autoconfigure tracing in HttpClient
      final WebClient.Builder builder) {
    this.webClient = WebClientUtils.createWebClient(builder, baseUrl, timeOutInMs, NAME);

    https: // resilience4j.readme.io/docs/circuitbreaker#create-and-configure-a-circuitbreaker
    this.defaultCircuitBreaker =
        CircuitBreaker.of(
            NAME,
            CircuitBreakerConfig.custom()
                .slidingWindowSize(10)
                .slidingWindowType(SlidingWindowType.COUNT_BASED)
                // api is offline
                .failureRateThreshold(70.0f)
                // api is slow
                .slowCallDurationThreshold(Duration.ofSeconds(2))
                .slowCallRateThreshold(70.0f)
                // wait for 10s
                .waitDurationInOpenState(Duration.ofSeconds(10))
                // verify threshold again
                .permittedNumberOfCallsInHalfOpenState(10)
                .build());
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

  public Mono<String> postWithCircuitBreaker(final Object request) {
    log.info("HTTP[{}] requestCb {}", NAME, request);
    return this.getWebClient()
        .post()
        .uri(POST.getUrl())
        .bodyValue(request)
        .retrieve()
        .bodyToMono(String.class)
        // .exchangeToMono(this::defaultResponseHandler)
        .transformDeferred(CircuitBreakerOperator.of(this.defaultCircuitBreaker));
  }

  // private Mono<String> defaultResponseHandler(final ClientResponse response) {
  //   final HttpStatusCode status = response.statusCode();
  //
  //   return response
  //       .bodyToMono(String.class)
  //       .defaultIfEmpty(StringUtils.EMPTY)
  //       .map(
  //           body -> {
  //             if (status.isError()) {
  //               throw new RuntimeException(
  //                   format("HTTP[%s] errorResponse '%s' '%s'", NAME, status.value(), body));
  //             }
  //             return body;
  //           });
  // }

  private Mono<String> defaultErrorHandler(final Throwable ex) {
    log.warn("HTTP[{}}] errorInternal '{}'", NAME, getErrorMessage(ex), ex);
    return Mono.empty();
  }
}
