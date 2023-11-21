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
  frontend interfaces, mobile applications and/or API depending on the client's requirements.
- **Back Office**: Operation and support applications that are vital for operational
  functionalities.
- **Internal**: APIs for external services like schedulers, jobs, webhooks [...] enabling seamless
  integration and enriching overall functionality.
- **Management**: API used by the development team to manage the platform. It is intentionally
  separated from the internal API for improved security.
- **Public API**: Public facing API

Each of these endpoints requires specific authentication mechanisms, collectively forming a robust
and flexible foundation for SaaS applications.

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
    - **Authentication:** Web/Mobile uses JWT, API uses API key.
    - **Authorization:** Web and mobile uses JWT role based access. It verifies platform_user
      and platform_admin role. API verifies the API key value and the associated
      company's database role _company.is_platform_.

### Back-office

- **URL:** `{{host}}/back-office/`
- **Description:** It provides APIs to efficiently manage back-office operations, usually serving as
  the interface between support and operation.
- **Auth:**
    - **Authentication:** It uses JWT.
    - **Authorization:** It uses JWT role based access and verify the presence of the
      back_office_user or back_office_admin role.

### Internal

- **URL:** `{{host}}/internal/`
- **Description:** Expose APIs for external services such as schedulers, jobs, and webhooks,
  allowing seamless integration with the platform.
- **Auth:**
    - **Authentication:** It uses API key.
    - **Authorization:** It validates the provided API key and associated company's database role
      _company.is_internal_.

### Management

- **URL:** `{{host}}/management/`
- **Description:** Designed to empower the development team, this endpoint offers APIs for managing
  and maintaining the entire platform.
- **Auth:**
    - **Authentication:** It uses API key.
    - **Authorization:** It validates the provided API key and associated company's database role
      _company.is_management_.

### Public

- **URL:** `{{host}}/public/`
- **Description:** This endpoint provides public facing information.

## Infra

### Authentication and Authorization

It uses Keycloak and Spring Security for authentication and implements a pretty simple Role-Based
Access Control (RBAC) for authorization. If you need a more complete approach I would recommend
Keycloak Attribute-based access control (ABAC).

### Database

It uses PostgreSQL for persistence and Flyway for managing migrations and schema versioning.

### Caching

It uses the default Spring cache mechanism, utilizing a `ConcurrentHashMap` object. It
can be extended to use a centralize cache like [Redis](https://redis.io/).

### Message Broker

Message handling is managed by RabbitMQ (using quorum queue), ensuring reliable and efficient
message delivery.

### Metrics & Tracing

It uses Prometheus and Micrometer to collect detailed metrics and tracing data, providing essential
insights into your application's behavior and performance.

### Rate Limiting

To maintain optimal performance and prevent abuse, a rate limiter is implemented. By default, it
limits each IP to 50 requests per second, helping balance server usage and maintain
responsiveness. Based on your use case, It can be more adequate to implement at the Load
Balancer level.

### Error Handling

It uses a consistent error handling strategy that prioritizes informative and descriptive error
responses. Errors are carefully categorized and presented with corresponding HTTP status codes
and clear error messages. It mostly uses RFC 7807.

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
make release
```

###### Hotfix

```bash
make hotfix # from main branch
```

### Formatting

It uses [Git Code Format Maven Plugin](https://github.com/Cosium/git-code-format-maven-plugin)
to unify java formatting. On commit, the hook will automatically format staged files.

### Postman Collection

For simplified API testing and integration, we provide a Postman collection and environment variable
file. Import our Postman collection to quickly get started.

Collection:

[![Collection](https://run.pstmn.io/button.svg)](https://github.com/Jojoooo1/spring-boot-api/tree/develop/postman/API.postman_collection.json)

Environment:

[![Dev environement](https://run.pstmn.io/button.svg)](https://github.com/Jojoooo1/spring-boot-api/tree/develop/postman/dev.postman_environment.json)

## Dependencies

The dependencies of the project are:

* OpenJDK Java version >= 21
* Spring boot >= 3.2
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

## Feedback and Support

We value your feedback and are committed to continuous improvement. If you have any suggestions,
encounter issues, or require assistance, please don't hesitate to reach out.

- **Feedback:** Feel free to open an issue or submit a pull request on
  our [GitHub repository](https://github.com/Jojoooo1/spring-boot-api/issues/new).
- **Support:** For further assistance or inquiries, please send me a message on
  [linkedin](https://www.linkedin.com/in/jonathan-chevalier-fr/).
