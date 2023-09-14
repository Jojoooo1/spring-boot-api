package com.mycompany.microservice.api.infra.ratelimit.base;

import io.github.bucket4j.Bandwidth;

public abstract class BaseRateLimit {
  public abstract String getName();

  public abstract Bandwidth getLimit();
}
