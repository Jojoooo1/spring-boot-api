### Medium

[A Comprehensive guide to Spring Boot 3.2 with Java 21, Virtual Threads, Spring Security, PostgreSQL, Flyway, Caching, Micrometer, Opentelemetry, JUnit 5, RabbitMQ, Keycloak Integration, and More! (10/17)](https://medium.com/itnext/exploring-a-base-spring-boot-application-with-java-21-virtual-thread-spring-security-flyway-c0fde13c1eca?source=user_profile---------4----------------------------)

# SaaS Base Project

## Introduction

Welcome to the API Documentation of the SaaS Base Project—a powerful foundation to help developers
build secure, resilient and robust SaaS applications. It's built with a strong focus on security
and performance, following best practices and industry-standard.

The main objective of this project is to suggest efficient implementation strategies commonly
observed in the SaaS landscape. By leveraging this project as a starting point, developers can
significantly improve their development process, enabling them to focus on creating business
logic and crafting application-specific features.

This documentation, provide a comprehensive details on the various API, each
addressing different aspects of a SaaS business:

- **Client Platform**: API dedicated to client-facing applications generally accessed through
  frontend interfaces, mobile applications and/or API.
- **Back Office**: Operation and support API for operational functionalities.
- **Internal**: APIs for external services like schedulers, jobs, webhooks [...] enabling seamless
  integration with the platform.
- **Management**: API used by the development team to manage the platform. It is intentionally
  separated from the internal API for improved security.
- **Public API**: Public facing API

## Table of Contents

- [API Endpoints](#api-endpoints)
    - [Platform](#platform)
    - [Back-office](#back-office)
    - [Internal](#internal)
    - [Management](#management)
    - [Public](#public)
- [Authentication and Authorization](#authentication-and-authorization)
- [Rate Limiting](#rate-limiting)
- [Message Broker](#message-broker)
- [Database](#database)
- [Database Migration](#database-migration)
- [Metrics](#metrics)
- [Tracing](#tracing)
- [Caching](#caching)
- [Postman Collection](#postman-collection)
- [Error Handling](#error-handling)
- [CI/CD](#ci/cd)
- [Formatting](#formatting)
- [Feedback and Support](#feedback-and-support)

## API Endpoints

### Platform

- **URL:** `{{host}}/platform/web/` `{{host}}/platform/mobile/` `{{host}}/platform/api/`
- **Description:** Client-facing applications. Divided in 3 categories based on your product
  supported
  platform. Separated for better isolation.
- **Auth:**
    - **Authentication:**
        - Web/mobile: JWT
        - API: API key
    - **Authorization:**
        - Web/mobile: JWT role based access. It verifies `platform_user` and `platform_admin` role.
        - API: API key role based access. It verifies the API key company's
          role `company.is_platform`.

### Back-office

- **URL:** `{{host}}/back-office/`
- **Description:** Provides APIs to efficiently manage back-office operations, usually serving as
  interface between support and operation.
- **Auth:**
    - **Authentication:**
        - JWT
    - **Authorization:**
        - JWT role based access. It verifies `back_office_user` and `back_office_admin` role.

### Internal

- **URL:** `{{host}}/internal/`
- **Description:** Expose APIs for external services such as schedulers, jobs, webhooks etc.
- **Auth:**
    - **Authentication:**
        - API key
    - **Authorization:**
        - API key role based access. It verifies the API key company's role `company.is_internal`.

### Management

- **URL:** `{{host}}/management/`
- **Description:** Designed to empower the development team, this endpoint offers APIs for managing
  and maintaining the entire platform.
- **Auth:**
    - **Authentication:**
        - JWT
    - **Authorization:**
        - JWT role based access. It verifies `management_user` and `management_admin` role.

### Public

- **URL:** `{{host}}/public/`
- **Description:** This endpoint provides public facing information.

## Infra

### Authentication and Authorization

It uses Keycloak and Spring Security for authentication and Role-Based Access Control (RBAC).
For a more fine-grained authorization you can use Keycloak Attribute-based access
control (ABAC).

If you would like to centralize the API key authorization in Keycloak, I would recommend using the
Resource Owner’s Password Credentials (easier to set up but deprecated in OAuth 2) or Client
Credentials Grant.

### Database

It uses PostgreSQL for persistence and Flyway for managing migrations and schema versioning.

### Caching

It uses the default Spring cache mechanism with `ConcurrentHashMap`. It
can be extended to use a centralized cache like [Redis](https://redis.io/).

### Message Broker

Message brokering is managed by RabbitMQ (using quorum queue), ensuring reliable and efficient
message delivery.

### Metrics & Tracing

It uses OpenTelemetry agent to collect detailed metrics and tracing data.

### Rate Limiting

By default, it limits each IP to 50 requests per second, helping balance server usage and maintain
responsiveness. It is usually more adequate to implement rate limiting at the Load Balancer level.

### Error Handling

It uses a consistent error handling strategy that prioritizes informative and descriptive error
responses. Errors are carefully categorized and presented with corresponding HTTP status codes
and clear error messages. It
uses [RFC 9457](https://datatracker.ietf.org/doc/html/rfc9457#name-members-of-a-problem-detail).

example:

```json
{
  "type": "about:blank",
  "title": "Bad Request",
  "status": 400,
  "detail": "Validation failed.",
  "instance": "/management/companies",
  "errors": [
    {
      "pointer": "slug",
      "reason": "must not be blank"
    }
  ]
}
```

### CI/CD - Gitflow

<div align="center">
<img src="https://nvie.com/img/git-model@2x.png" height="600">
</div>

###### Long-lived branches

- `origin/main`
    - Always reflects a production-ready state.
- `origin/develop`
    - Always reflects a state with the latest delivered development changes for the next release.

###### Release

```bash
make release # from develop
```

###### Hotfix

```bash
make hotfix # from main
```

### Formatting

It uses [Git Code Format Maven Plugin](https://github.com/Cosium/git-code-format-maven-plugin)
to unify java formatting. On commit, the hook will automatically format staged files.

### Postman Collection

Import Postman collection to quickly get started.

Collection:

[![Collection](https://run.pstmn.io/button.svg)](https://github.com/Jojoooo1/spring-boot-api/tree/develop/postman/API.postman_collection.json)

Environment:

[![Dev environement](https://run.pstmn.io/button.svg)](https://github.com/Jojoooo1/spring-boot-api/tree/develop/postman/dev.postman_environment.json)

## Dependencies

The dependencies of the project are:

* OpenJDK Java version >= 21
* [Docker](https://www.docker.com)
* [Docker Compose](https://docs.docker.com/compose/)
* [Maven](https://maven.apache.org/)

## Run project

```bash
make start-all
```

## Debug project

```bash
make start-infra
```

```bash
make run-api
```

## Test project

```bash
make test
```

## Clean the project

```bash
make kill
```

## OpenTelemetry Automatic Instrumentation

[documentation](https://opentelemetry.io/docs/languages/java/automatic/) /
[java-instrumentation](https://github.com/open-telemetry/opentelemetry-java-instrumentation)

JVM options:

```
-javaagent:path-to-your-project/opentelemetry/opentelemetry-javaagent.jar
-Dotel.javaagent.configuration-file=path-to-your-project/opentelemetry/dev.properties
```

- For debugging tracing exporter, set `otel.traces.exporter=otlp` in `opentelemetry/dev.properties`
  and use [otel-desktop-viewer](https://github.com/CtrlSpice/otel-desktop-viewer)
- For debugging metrics exporter, set `otel.metrics.exporter=logging`
  in `opentelemetry/dev.properties`

## OpenTelemetry & Buildpack

To build the image:

```
mvn clean package -DskipTests spring-boot:build-image
```

To run the image with otel agent:

```
docker run --net host \
     -e SPRING_PROFILES_ACTIVE=dev \
     -e SPRING_DATASOURCE_URL="jdbc:postgresql://localhost:5432/api" \
     -e JAVA_TOOL_OPTIONS="-javaagent:/workspace/opentelemetry/opentelemetry-javaagent.jar" \
     -e OTEL_JAVAAGENT_CONFIGURATION_FILE=/workspace/opentelemetry/default.properties \
     -e OTEL_TRACES_EXPORTER=otlp \
     -e OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317 \
     api:0.0.1-SNAPSHOT
```

## Spring native

Limitations:

- Flyway: Automatic detection of Java migrations are not supported in native image,
  see [#33458](https://github.com/spring-projects/spring-boot/issues/33458)
- Many [others](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-with-GraalVM#known-graalvm-native-image-limitations) small issues

## Feedback and Support

We value your feedback and are committed to continuous improvement. If you have any suggestions,
encounter issues, or require assistance, please don't hesitate to reach out.

- **Feedback:** Feel free to open an issue or submit a pull request on
  our [GitHub repository](https://github.com/Jojoooo1/spring-boot-api/issues/new).
- **Support:** For further assistance or inquiries, please send me a message on
  [linkedin](https://www.linkedin.com/in/jonathan-chevalier-fr/).
