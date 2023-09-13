package com.mycompany.microservice.api.clients.http;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum WebhookSiteUrlEnum {
  POST("/");
  private final String url;
}
