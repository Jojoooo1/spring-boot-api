# SaaS Base Project

## Introduction

Welcome to the API Documentation for the SaaS Base Project—a powerful foundation to help developers
in building secure, resilient and robust SaaS applications. The project offers a collection of APIs,
categorized into essential components of a Saas business.

The main objective of this project is to exemplify best practices, presenting a refined
architecture, and recommending efficient implementation strategies commonly observed in SaaS
landscape. By leveraging this project as a starting point, developers can significantly expedite
their development process, enabling them to focus on tailoring business logic and features specific
to their applications.

This documentation, provide a comprehensive details on the various endpoints, each
catering different aspects of a SaaS application:

- **Platform**: API dedicated to client-facing applications, typically accessed through frontend
  interfaces or mobile applications. Alternatively, it can be consumed through API calls, tailored
  to the client's needs and the service provided.
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
- **Description:** Serves as the gateway for client applications to interact with
  the provided Saas service.
- **Auth:**
    - **Authentication:** It uses a mix of api-key and JWT.
    - **Authorization:** The API endpoint is secured by looking at the api-key and the company
      linked to it. It verifies that the company.is_platform field is set to true.

      The frontend and mobile endpoint is secured by looking at the role from the JWT. It should
      have platform_user and or platform_admin role present.

### Back-office

- **URL:** `{{host}}/back-office/`
- **Description:**  Those endpoints serves as the interface for the operation and support team. It
  provides APIs to efficiently manage back-office operations.
- **Auth:**
    - **Authentication:** It uses JWT.
    - **Authorization:** It verifies that the JWT as either the back_office_user or
      back_office_admin role present.

### Internal

- **URL:** `{{host}}/internal/`
- **Description:** Expose APIs for external services such as schedulers, jobs, and webhooks,
  allowing seamless integration with the platform.
- **Auth:**
    - **Authentication:** It uses API key.
    - **Authorization:** It verifies that the company linked to the api-key has the
      company.is_internal field set to true.

### Management

- **URL:** `{{host}}/management/`
- **Description:** Designed to empower the development team, this endpoint offers APIs for managing
  and maintaining the entire platform.
- **Auth:**
    - **Authentication:** It uses API key.
    - **Authorization:** It verifies that the company linked to the api-key has the
      company.is_management field set to true.

### Public

- **URL:** `{{host}}/public/`
- **Description:** This endpoint is dedicated to providing public information about the service,
  ensuring transparency and accessibility for all users.

## Infra

### Authentication and Authorization

Authentication and authorization are pivotal aspects of any application. In this project, we utilize
Keycloak and Spring Security to handle these critical processes. The authorization mechanisms are
primarily based on the well-established Role-Based Access Control (RBAC) model, ensuring secure
access control.

### Database

Data persistence is vital for applications, and PostgreSQL, a powerful open-source relational
database management system, is employed to handle this crucial aspect efficiently.

### Database Migration

Managing database migrations is simplified using Flyway. This tool allows for seamless database
schema versioning and migration, ensuring smooth transitions and updates.

### Caching

Caching frequently accessed data is vital for optimizing application performance. This project
leverages the default Spring cache mechanism, utilizing a concurrent hash map object. It can
obviously be improved to use a centralized cache like [Redis](https://redis.io/).

### Message Broker

Message handling, an integral part of any scalable and robust system, is seamlessly managed by
RabbitMQ (using quorum queue). This ensures reliable and efficient message delivery.

### Metrics

Monitoring system health and performance are critical. We utilize Prometheus and
Micrometer to gather and visualize metrics effectively.

### Tracing

Understanding the flow and behavior of the application is essential. Micrometer, coupled with the
OpenTelemetry Protocol (OTLP), facilitates efficient tracing, providing insights into system
behavior and performance optimization opportunities.

### Rate Limiting

To maintain optimal performance and prevent abuse, a rate limiter is implemented. By default, it
allows a maximum of 50 requests per second per IP, effectively managing server load and ensuring
responsive services.

### Error Handling

Error handling is an essential aspect of any API. This project employs a comprehensive error
handling approach to ensure informative and consistent error responses are provided. Errors are
categorized and accompanied by relevant HTTP status codes and error messages, aiding in efficient
debugging and issue resolution.

### Postman Collection

For simplified API testing and integration, we provide a Postman collection and environment variable
file. Import our Postman collection to quickly get started.

Collection:

[![Collection](https://run.pstmn.io/button.svg)](https://github.com/Jojoooo1/spring-boot-api/tree/develop/postman/API.postman_collection.json)

Environment:

[![Dev environement](https://run.pstmn.io/button.svg)](https://github.com/Jojoooo1/spring-boot-api/tree/develop/postman/dev.postman_environment.json)

## Dependencies

The dependencies of the project are:

* OpenJDK Java version >= 17
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
