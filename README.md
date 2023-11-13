# SaaS Base Project

## Introduction

Welcome to the API Documentation of the SaaS Base Project—a powerful foundation to help developers
build secure, resilient and robust SaaS applications. It's built with a strong focus on security
and performance, following best practices and organized into essential components of a SaaS
business.

The main objective of this project is to showcase industry-standard practices, presenting a refined
architecture, and suggesting efficient implementation strategies commonly observed in the SaaS
landscape. By leveraging this project as a starting point, developers can significantly improve
their development process, enabling them to focus on creating business logic and crafting
application-specific features.

This documentation, provide a comprehensive details on the various endpoints, each
addressing different aspects of a SaaS application:

- **Platform**: API dedicated to client-facing applications, typically accessed through frontend
  interfaces or mobile applications. Alternatively, it can be consumed through API calls, tailored
  to the client's needs and service provided.
- **Back Office**: Streamlines operation and support applications that are vital for operational
  functionalities.
- **Internal**: APIs for external services like schedulers, jobs, webhooks [...] enabling seamless
  integration with the platform and enriching overall functionality.
- **Management**: API used by the development team for managing the application and its
  resources. It is intentionally separated from the internal API for improved security.
- **Public API**: Simplifies access to publicly available resources, enhancing overall accessibility
  and usability.

Each of these endpoints requires specific authentication mechanisms, and they collectively form the
foundation for a robust and flexible SaaS application.

## Table of Contents

- [Overview](#introduction)
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
- [Feedback and Support](#feedback-and-support)

## API Endpoints

### Platform

- **URL:** `{{host}}/platform/web/` `{{host}}/platform/mobile/` `{{host}}/platform/api/`
- **Description:** Client facing applications. Divided in 3 categories based on your production
  platform. Separated for better isolation.
- **Auth:**
    - **Authentication:** It uses a mix of api-key and JWT.
    - **Authorization:** The API endpoint is secured by validating the provided API key and
      verifying the associated company's. It also verifies that the company.is_platform field is
      set to true. In the case of frontend and mobile endpoints, security is ensured by examining
      the role field within the JWT. Verification involves confirming the presence of either the
      platform_user or platform_admin role.

### Back-office

- **URL:** `{{host}}/back-office/`
- **Description:**  Those endpoints serves as the interface for the operation and support team. It
  provides APIs to efficiently manage back-office operations.
- **Auth:**
    - **Authentication:** It uses JWT.
    - **Authorization:** It verifies that the JWT has either the back_office_user or
      back_office_admin role present.

### Internal

- **URL:** `{{host}}/internal/`
- **Description:** Expose APIs for external services such as schedulers, jobs, and webhooks,
  allowing seamless integration with the platform.
- **Auth:**
    - **Authentication:** It uses API key.
    - **Authorization:** It validates the provided API key and verify the associated company's.
      It also verifies that the company.is_internal field is set to true.

### Management

- **URL:** `{{host}}/management/`
- **Description:** Designed to empower the development team, this endpoint offers APIs for managing
  and maintaining the entire platform.
- **Auth:**
    - **Authentication:** It uses API key.
    - **Authorization:** It validates the provided API key and verify the associated company's.
      It also verifies that the company.is_management field is set to true.

### Public

- **URL:** `{{host}}/public/`
- **Description:** This endpoint is dedicated to providing public information about the service,
  ensuring transparency and accessibility for all users.

## Infra

### Authentication and Authorization

Keycloak and Spring Security manage authentication and authorization, ensuring secure access control
by relying on the Role-Based Access Control (RBAC) model.

### Database

It uses PostgreSQL and Flyway to manage database migrations and schema versioning.

### Caching

The project leverages the default Spring cache mechanism, utilizing a concurrent hash map object. It
can be extended to use a centralize cache like [Redis](https://redis.io/).

### Message Broker

Message handling is managed by RabbitMQ (using quorum queue), ensuring reliable and efficient
message delivery.

### Metrics & Tracing

It use Prometheus and Micrometer to collect detailed metrics and tracing data, providing essential
insights into the application's behavior and performance.

### Rate Limiting

To maintain optimal performance and prevent abuse, a rate limiter is implemented. By default, it
limits each IP to 50 requests per second, helping balance server usage and maintain responsiveness.

### Error Handling

We use a consistent error handling strategy that prioritizes informative and descriptive error
responses. Errors are carefully categorized and presented with corresponding HTTP status codes
and clear error messages.

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
* [Postgres](https://www.postgresql.org)
* [Keycloak](https://www.keycloak.org/)
* [RabbitMQ](https://www.rabbitmq.com/)

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
