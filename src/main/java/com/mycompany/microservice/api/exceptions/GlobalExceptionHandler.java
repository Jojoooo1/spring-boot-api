package com.mycompany.microservice.api.exceptions;

import static com.mycompany.microservice.api.constants.AppConstants.API_DEFAULT_ERROR_MESSAGE;
import static com.mycompany.microservice.api.constants.AppConstants.API_DEFAULT_REQUEST_FAILED_MESSAGE;
import static java.lang.String.format;
import static java.util.Collections.emptyList;
import static org.springframework.http.HttpStatus.BAD_REQUEST;

import com.mycompany.microservice.api.responses.shared.ApiErrorDetails;
import java.sql.BatchUpdateException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.LazyInitializationException;
import org.postgresql.util.PSQLException;
import org.springframework.core.NestedExceptionUtils;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.*;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.lang.NonNull;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@Slf4j
@ControllerAdvice
@RequiredArgsConstructor
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

  @Override
  protected ResponseEntity<Object> handleMethodArgumentNotValid(
      @NonNull final MethodArgumentNotValidException ex,
      @NonNull final HttpHeaders headers,
      @NonNull final HttpStatusCode status,
      @NonNull final WebRequest request) {
    log.info(ex.getMessage(), ex);

    final List<ApiErrorDetails> errors = new ArrayList<>();

    for (final ObjectError err : ex.getBindingResult().getAllErrors()) {
      if (err instanceof FieldError) {
        errors.add(
            ApiErrorDetails.builder()
                .reason(err.getDefaultMessage())
                .pointer(((FieldError) err).getField())
                .build());
      }
    }

    return ResponseEntity.status(BAD_REQUEST)
        .body(this.buildProblemDetail(BAD_REQUEST, "Validation failed.", errors));
  }

  @ResponseStatus(BAD_REQUEST)
  @ExceptionHandler({jakarta.validation.ConstraintViolationException.class})
  public ProblemDetail handleJakartaConstraintViolationException(
      final jakarta.validation.ConstraintViolationException ex, final WebRequest request) {
    log.info(ex.getMessage(), ex);

    final List<ApiErrorDetails> errors = new ArrayList<>();
    for (final var violation : ex.getConstraintViolations()) {
      errors.add(
          ApiErrorDetails.builder()
              .reason(violation.getMessage())
              .pointer(violation.getPropertyPath().toString())
              .build());
    }

    return this.buildProblemDetail(BAD_REQUEST, "Validation failed.", errors);
  }

  @ResponseStatus(BAD_REQUEST)
  @ExceptionHandler({
    org.hibernate.exception.ConstraintViolationException.class,
    DataIntegrityViolationException.class,
    BatchUpdateException.class,
    jakarta.persistence.PersistenceException.class,
    PSQLException.class
  })
  public ProblemDetail handlePersistenceException(final Exception ex, final WebRequest request) {
    log.info(ex.getMessage(), ex);

    final String cause = NestedExceptionUtils.getMostSpecificCause(ex).getLocalizedMessage();
    final String errorDetail = this.extractPersistenceDetails(cause);
    return this.buildProblemDetail(BAD_REQUEST, errorDetail);
  }

  @ResponseStatus(HttpStatus.FORBIDDEN)
  @ExceptionHandler({AccessDeniedException.class})
  public ProblemDetail handleAccessDeniedException(final Exception ex, final WebRequest request) {
    log.info(ex.getMessage(), ex);
    return this.buildProblemDetail(HttpStatus.FORBIDDEN, null);
  }

  @ResponseStatus(HttpStatus.NOT_FOUND)
  @ExceptionHandler(EmptyResultDataAccessException.class)
  public ProblemDetail handleEmptyResultDataAccessException(
      final EmptyResultDataAccessException ex, final WebRequest request) {
    log.info(ex.getMessage(), ex);

    return this.buildProblemDetail(HttpStatus.NOT_FOUND, "no record found for this id");
  }

  @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
  @ExceptionHandler(LazyInitializationException.class)
  public ProblemDetail handleLazyInitialization(
      final LazyInitializationException ex, final WebRequest request) {

    log.warn(ex.getMessage(), ex);

    // this.slack.notify(format("LazyInitializationException: %s", ex.getMessage()));

    return this.buildProblemDetail(HttpStatus.INTERNAL_SERVER_ERROR, API_DEFAULT_ERROR_MESSAGE);
  }

  @ExceptionHandler(RootException.class)
  public ResponseEntity<ProblemDetail> rootException(final RootException ex) {
    log.info(ex.getMessage(), ex);

    // if (ex.getHttpStatus().is5xxServerError()) {
    //   this.slack.notify(format("[API] InternalServerError: %s", ex.getMessage()));
    // }

    final ProblemDetail problemDetail =
        this.buildProblemDetail(
            ex.getHttpStatus(), API_DEFAULT_REQUEST_FAILED_MESSAGE, ex.getErrors());
    return ResponseEntity.status(ex.getHttpStatus()).body(problemDetail);
  }

  // All unknown exception will fallback in this function.
  @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
  @ExceptionHandler(Throwable.class)
  public ProblemDetail handleAllExceptions(final Throwable ex, final WebRequest request) {
    log.warn(format("%s", ex.getMessage()), ex);

    // this.slack.notify(format("[API] InternalServerError: %s", ex.getMessage()));

    return this.buildProblemDetail(HttpStatus.INTERNAL_SERVER_ERROR, API_DEFAULT_ERROR_MESSAGE);
  }

  /*
   *
   * Override in order to facilitate error debug.
   * */
  @Override
  protected ResponseEntity<Object> handleHttpMessageNotWritable(
      @NonNull final HttpMessageNotWritableException ex,
      @NonNull final HttpHeaders headers,
      @NonNull final HttpStatusCode stat,
      @NonNull final WebRequest request) {
    log.warn(format("%s", ex.getMessage()), ex);

    // this.slack.notify(format("[API] InternalServerError: %s", ex.getMessage()));

    final HttpStatus status = HttpStatus.valueOf(stat.value());
    return ResponseEntity.status(status)
        .body(this.buildProblemDetail(status, API_DEFAULT_ERROR_MESSAGE));
  }

  private ProblemDetail buildProblemDetail(final HttpStatus status, final String detail) {
    return this.buildProblemDetail(status, detail, emptyList());
  }

  private ProblemDetail buildProblemDetail(
      final HttpStatus status, final String detail, final List<ApiErrorDetails> errors) {

    final ProblemDetail problemDetail =
        ProblemDetail.forStatusAndDetail(status, StringUtils.normalizeSpace(detail));
    if (CollectionUtils.isNotEmpty(errors)) {
      problemDetail.setProperty("errors", errors);
    }
    // problemDetail.setProperty("timestamp",
    // DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss").format(LocalDateTime.now()));

    return problemDetail;
  }

  private String extractPersistenceDetails(final String cause) {

    String details = API_DEFAULT_ERROR_MESSAGE;

    // Example: ERROR: duplicate key value violates unique constraint "company_slug_key"  Detail:
    // Key (slug)=(bl8lo0d) already exists.
    if (cause.contains("Detail")) {
      final List<String> matchList = new ArrayList<>();
      // find database values between "()"
      final Pattern pattern = Pattern.compile("\\((.*?)\\)");
      final Matcher matcher = pattern.matcher(cause);

      // Creates list ["slug", "bl8lo0d"]
      while (matcher.find()) {
        matchList.add(matcher.group(1));
      }

      if (matchList.size() == 2) {
        final String key = matchList.get(0);
        final String value = matchList.get(1);
        // Gets the message after the last ")"
        final String message = cause.substring(cause.lastIndexOf(")") + 1);

        // return errorMessage: slug 'bl8lo0d'  already exists.
        details = format("%s '%s' %s", key, value, message);
      }
    }

    return details;
  }
}
