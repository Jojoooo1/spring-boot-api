package com.mycompany.microservice.api.exceptions;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

import java.io.Serial;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = BAD_REQUEST)
public class BadRequestException extends RootException {

  @Serial private static final long serialVersionUID = 1L;

  public BadRequestException(final String message) {
    super(BAD_REQUEST, message);
  }
}
