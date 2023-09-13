package com.mycompany.microservice.api.exceptions;

import static java.lang.String.format;
import static org.springframework.http.HttpStatus.NOT_FOUND;

import java.io.Serial;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = NOT_FOUND)
public class ResourceNotFoundException extends RootException {

  @Serial private static final long serialVersionUID = 26377136569699646L;

  public ResourceNotFoundException(final Long id) {
    super(NOT_FOUND, format("entity with id '%s' not found", id));
  }

  public ResourceNotFoundException(final String message) {
    super(NOT_FOUND, message);
  }
}
