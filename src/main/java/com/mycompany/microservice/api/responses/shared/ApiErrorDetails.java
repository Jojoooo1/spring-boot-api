package com.mycompany.microservice.api.responses.shared;

import java.io.Serializable;
import lombok.Builder;

@Builder
public record ApiErrorDetails(String reason, String pointer) implements Serializable {}
