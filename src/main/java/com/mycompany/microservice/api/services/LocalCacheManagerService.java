package com.mycompany.microservice.api.services;

import static com.mycompany.microservice.api.constants.AppHeaders.API_KEY_HEADER;
import static java.lang.String.format;

import com.mycompany.microservice.api.constants.AppCompanySlug;
import com.mycompany.microservice.api.controllers.internal.CacheInternalApiController;
import java.util.Collections;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 * LocalCacheManagerService:
 *
 * <p>Only use this service if the cache provider is concurrentHashMap. It provides utility function
 * to help clearing local caches.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class LocalCacheManagerService {

  @Value("${kubernetes.service-name}")
  final String kubernetesServiceName;

  private final ApiKeyService apiKeyService;
  private final CompanyService companyService;
  private final DiscoveryClient discoveryClient;
  private final RestTemplate restTemplate;
  private final CacheManager cacheManager;

  public void evictByName(final String cacheName) {
    final Cache cache = this.cacheManager.getCache(cacheName);
    if (cache != null) {
      cache.clear();
      log.info("[cache-eviction] evicted local cache '{}'", cacheName);
    }
  }

  public void evictAll() {
    this.cacheManager.getCacheNames().forEach(name -> this.cacheManager.getCache(name).clear());
    log.info("[cache-eviction] evicted all local caches");
  }

  public void evictCacheInAllKubernetesInstances() {
    this.evictCacheInAllKubernetesInstances(StringUtils.EMPTY);
  }

  @Async
  public void evictCacheInAllKubernetesInstances(final String cacheName) {

    final List<ServiceInstance> instances =
        this.discoveryClient.getInstances(this.kubernetesServiceName);

    instances.forEach(
        instance -> {
          final String url =
              format(
                  "%s%s%s",
                  instance.getUri(),
                  CacheInternalApiController.BASE_URL,
                  StringUtils.isBlank(cacheName) ? StringUtils.EMPTY : "/" + cacheName);
          log.info("[cache-eviction] sending request to evict cache for '{}'", url);
          this.restTemplate.exchange(url, HttpMethod.POST, this.buildRequest(), Void.class);
        });
  }

  private HttpEntity<String> buildRequest() {
    final HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
    headers.add(API_KEY_HEADER, this.getInternalApikey());
    return new HttpEntity<>(null, headers);
  }

  private String getInternalApikey() {
    final Long companyId = this.companyService.findBySlug(AppCompanySlug.INTERNAL).getId();
    return this.apiKeyService.findFirstByCompanyIdAndIsActive(companyId).getKey();
  }
}
