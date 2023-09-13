package com.mycompany.microservice.api.exceptions;

import static org.springframework.http.HttpStatus.FORBIDDEN;

import java.io.Serial;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = FORBIDDEN)
public class NotAllowedException extends RootException {

  @Serial private static final long serialVersionUID = 1L;

  public NotAllowedException() {
    super(FORBIDDEN);
  }
}
