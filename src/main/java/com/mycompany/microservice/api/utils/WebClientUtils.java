package com.mycompany.microservice.api.utils;

import io.netty.channel.ChannelOption;
import io.netty.handler.timeout.ReadTimeoutHandler;
import io.netty.handler.timeout.WriteTimeoutHandler;
import java.time.Duration;
import java.util.concurrent.TimeUnit;
import java.util.function.Consumer;
import lombok.experimental.UtilityClass;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClient.Builder;
import reactor.netty.http.client.HttpClient;

@UtilityClass
public class WebClientUtils {

  private Consumer<HttpHeaders> defaultHttpHeaders() {
    return headers -> {
      headers.set(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
      headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
    };
  }

  public static WebClient createWebClient(
      final Builder builder,
      final String baseUrl,
      final int timeOutInMs,
      final ExchangeFilterFunction errorHandler) {

    final Builder webClientBuilder =
        builder
            .clientConnector(
                new ReactorClientHttpConnector(createHttpClientWithProvider(timeOutInMs)))
            .baseUrl(baseUrl)
            .defaultHeaders(defaultHttpHeaders());

    if (errorHandler != null) {
      webClientBuilder.filters(
          exchangeFilterFunctions -> exchangeFilterFunctions.add(errorHandler));
    }

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
}
