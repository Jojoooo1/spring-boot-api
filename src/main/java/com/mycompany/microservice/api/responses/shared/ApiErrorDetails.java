package com.mycompany.microservice.api.responses.shared;

import java.io.Serializable;
import lombok.Builder;

@Builder
public record ApiErrorDetails(Long code, String name, String reason) implements Serializable {}
