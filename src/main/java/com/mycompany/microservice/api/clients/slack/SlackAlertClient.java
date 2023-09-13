package com.mycompany.microservice.api.clients.slack;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

@Slf4j
@Profile("!test")
@Getter
@Component
public class SlackAlertClient extends BaseSlackClient {

  private final String url;
  private final String channel;
  private final String username;

  public SlackAlertClient(
      @Value("${slack.username}") final String username,
      @Value("${slack.channels.api-alert.url}") final String url,
      @Value("${slack.channels.api-alert.name}") final String channel) {
    this.username = username;
    this.url = url;
    this.channel = channel;
  }
}
