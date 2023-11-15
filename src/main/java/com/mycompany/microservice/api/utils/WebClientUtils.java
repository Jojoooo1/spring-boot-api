package com.mycompany.microservice.api.utils;

import io.netty.channel.ChannelOption;
import io.netty.handler.ssl.SslClosedEngineException;
import io.netty.handler.timeout.ReadTimeoutHandler;
import io.netty.handler.timeout.WriteTimeoutHandler;
import java.time.Duration;
import java.util.concurrent.TimeUnit;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClient.Builder;
import reactor.netty.http.client.HttpClient;
import reactor.netty.http.client.PrematureCloseException;
import reactor.util.retry.Retry;

@Slf4j
@UtilityClass
public class WebClientUtils {

  public static WebClient createWebClient(
      final Builder builder, final String baseUrl, final int timeOutInMs, final String name) {

    final Builder webClientBuilder =
        builder
            .clientConnector(
                new ReactorClientHttpConnector(createHttpClientWithProvider(timeOutInMs)))
            .baseUrl(baseUrl)
            .defaultHeader(
                HttpHeaders.CONTENT_TYPE,
                MediaType.APPLICATION_JSON_VALUE,
                HttpHeaders.ACCEPT,
                MediaType.APPLICATION_JSON_VALUE)
            .filter(retryOnNetworkInstability())
            .filter(logResponse(name));

    return webClientBuilder.build();
  }

  public static HttpClient createHttpClientWithProvider(final int timeOutInMs) {
    return HttpClient.create()
        .option(ChannelOption.CONNECT_TIMEOUT_MILLIS, timeOutInMs)
        .responseTimeout(Duration.ofMillis(timeOutInMs))
        .doOnConnected(
            conn ->
                conn.addHandlerLast(new ReadTimeoutHandler(timeOutInMs, TimeUnit.MILLISECONDS))
                    .addHandlerLast(new WriteTimeoutHandler(timeOutInMs, TimeUnit.MILLISECONDS)));
  }

  public static String getErrorMessage(final Throwable ex) {
    final Throwable rootCause = ExceptionUtils.getRootCause(ex);
    return StringUtils.isBlank(rootCause.getMessage())
        ? rootCause.getClass().getSimpleName()
        : rootCause.getMessage();
  }

  /*
   * Error handler to improve network reliability.
   * */
  private ExchangeFilterFunction retryOnNetworkInstability() {
    return (request, next) ->
        next.exchange(request)
            .retryWhen(
                Retry.backoff(3, Duration.ofMillis(100))
                    .filter(
                        ex -> {
                          if (ExceptionUtils.getRootCause(ex) instanceof PrematureCloseException) {
                            log.info("HTTP[RETRY] PrematureCloseException detected retrying");
                            return true;
                          } else if (ExceptionUtils.getRootCause(ex)
                              instanceof SslClosedEngineException) {
                            log.info("HTTP[RETRY] SslClosedEngineException detected retrying");
                            return true;
                          }
                          return false;
                        }));
  }

  public static ExchangeFilterFunction logResponse(final String webClientName) {
    return ExchangeFilterFunction.ofResponseProcessor(
        response -> {
          final HttpStatusCode status = response.statusCode();
          return response
              .bodyToMono(String.class)
              // Force mono execution on empty response or will throw IllegalStateException
              .defaultIfEmpty(StringUtils.EMPTY)
              .map(
                  body -> {
                    if (status.is2xxSuccessful()) {
                      log.info("HTTP[{}] response {} '{}'", webClientName, status.value(), body);
                    } else {
                      log.warn(
                          "HTTP[{}] errorResponse '{}' '{}'", webClientName, status.value(), body);
                    }
                    return response;
                  });
        });
  }
}
