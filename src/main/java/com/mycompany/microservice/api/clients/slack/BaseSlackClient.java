package com.mycompany.microservice.api.clients.slack;

import com.slack.api.Slack;
import com.slack.api.webhook.WebhookResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;

@Slf4j
public abstract class BaseSlackClient {

  public abstract String getUsername();

  public abstract String getUrl();

  public abstract String getChannel();

  @Async
  public void notify(final String message) {
    try {

      // Build your own error message template like:
      // https://app.slack.com/block-kit-builder/T05675Y01#%7B%22blocks%22:%5B%7B%22type%22:%22section%22,%22text%22:%7B%22type%22:%22mrkdwn%22,%22text%22:%22You%20have%20a%20new%20request:%5Cn*%3CfakeLink.toEmployeeProfile.com%7CFred%20Enriquez%20-%20New%20device%20request%3E*%22%7D%7D,%7B%22type%22:%22section%22,%22fields%22:%5B%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Type:*%5CnComputer%20(laptop)%22%7D,%7B%22type%22:%22mrkdwn%22,%22text%22:%22*When:*%5CnSubmitted%20Aut%2010%22%7D,%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Last%20Update:*%5CnMar%2010,%202015%20(3%20years,%205%20months)%22%7D,%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Reason:*%5CnAll%20vowel%20keys%20aren't%20working.%22%7D,%7B%22type%22:%22mrkdwn%22,%22text%22:%22*Specs:*%5Cn%5C%22Cheetah%20Pro%2015%5C%22%20-%20Fast,%20really%20fast%5C%22%22%7D%5D%7D,%7B%22type%22:%22actions%22,%22elements%22:%5B%7B%22type%22:%22button%22,%22text%22:%7B%22type%22:%22plain_text%22,%22emoji%22:true,%22text%22:%22Approve%22%7D,%22style%22:%22primary%22,%22value%22:%22click_me_123%22%7D,%7B%22type%22:%22button%22,%22text%22:%7B%22type%22:%22plain_text%22,%22emoji%22:true,%22text%22:%22Deny%22%7D,%22style%22:%22danger%22,%22value%22:%22click_me_123%22%7D%5D%7D%5D%7D
      // Usually you would put a link with yours logs and traces
      final WebhookResponse response =
          Slack.getInstance().send(this.getUrl(), "Insert your body message");

      if (response.getCode() != 200) {
        log.warn(
            "[SLACK - {}][ERROR] status[{}] body[{}]",
            this.getChannel(),
            response.getCode(),
            response.getBody());

      } else {
        log.info("[SLACK] error message send with success");
      }

    } catch (final Exception ex) {
      log.error("[SLACK] An error has occurred when sending error message", ex);
    }
  }
}
