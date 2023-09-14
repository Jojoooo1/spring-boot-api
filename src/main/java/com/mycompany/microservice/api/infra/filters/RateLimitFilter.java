package com.mycompany.microservice.api.infra.filters;

import static org.springframework.http.HttpStatus.TOO_MANY_REQUESTS;

import com.mycompany.microservice.api.infra.ratelimit.DefaultRateLimit;
import com.mycompany.microservice.api.infra.ratelimit.base.BaseRateLimit;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.ConsumptionProbe;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Slf4j
@Component
@RequiredArgsConstructor
public class RateLimitFilter extends OncePerRequestFilter {

  private final DefaultRateLimit defaultRateLimit;
  private final Map<String, Bucket> cache = new ConcurrentHashMap<>();

  @Override
  protected void doFilterInternal(
      @NonNull final HttpServletRequest request,
      @NonNull final HttpServletResponse response,
      @NonNull final FilterChain filterChain)
      throws ServletException, IOException {

    final Bucket bucket = this.resolveBucket(request);
    final ConsumptionProbe probe = bucket.tryConsumeAndReturnRemaining(1);

    if (probe.isConsumed()) {
      // Uncomment if you want to show remaining token (request) before being rate limited
      // response.addHeader(HEADER_RATE_LIMIT_REMAINING,
      // String.valueOf(probe.getRemainingTokens()));
      filterChain.doFilter(request, response);
    } else {

      // final long waitForRefill = probe.getNanosToWaitForRefill() / 1_000_000_000;

      response.reset();
      // Uncomment if you want to show remaining time before the rate limit will be reset (refill).
      // response.addHeader(RATE_LIMIT_RETRY_AFTER_SECONDS_HEADER, String.valueOf(waitForRefill));
      response.setContentType(MediaType.APPLICATION_JSON_VALUE);
      response.setStatus(TOO_MANY_REQUESTS.value());
    }
  }

  private Bucket resolveBucket(final HttpServletRequest request) {
    final BaseRateLimit rateLimit = this.getRateLimitFor(request.getRequestURI());
    return this.cache.computeIfAbsent(
        // We rate limit user based on their IP
        request.getRemoteAddr(), s -> Bucket.builder().addLimit(rateLimit.getLimit()).build());
  }

  private BaseRateLimit getRateLimitFor(final String requestedUri) {
    // We can use a switch case if we want to rate limit multiple URL.
    return this.defaultRateLimit;
  }
}
