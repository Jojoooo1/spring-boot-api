package com.mycompany.microservice.api.controllers.platform.mobile;

import com.mycompany.microservice.api.constants.AppUrls;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping(PlatformMobileController.BASE_URL)
@RequiredArgsConstructor
public class PlatformMobileController {
  public static final String BASE_URL = AppUrls.PLATFORM_MOBILE;

  @GetMapping("/hello-world")
  @ResponseStatus(HttpStatus.OK)
  public String helloWorld() {
    return "Hello world";
  }
}
