package com.mycompany.microservice.api.responses.shared;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.io.Serializable;
import lombok.Builder;

@Builder
public record ApiErrorDetails(String reason, @JsonInclude(Include.NON_NULL) String pointer)
    implements Serializable {}
