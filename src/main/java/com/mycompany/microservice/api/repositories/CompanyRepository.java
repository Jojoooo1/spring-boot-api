package com.mycompany.microservice.api.repositories;

import com.mycompany.microservice.api.entities.Company;
import java.util.List;
import java.util.Optional;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.NonNull;

public interface CompanyRepository extends JpaRepository<Company, Long> {

  String CACHE_NAME = "company";

  @NonNull
  @Cacheable(value = CACHE_NAME, key = "{'byId', #id}")
  @Override
  Optional<Company> findById(@NonNull Long id);

  @Cacheable(value = CACHE_NAME, key = "{'bySlug', #slug}")
  Optional<Company> findBySlug(String slug);

  @Caching(
      evict = {
        @CacheEvict(value = CACHE_NAME, key = "{'byId', #entity.id}"),
        @CacheEvict(value = CACHE_NAME, key = "{'bySlug', #entity.slug}"),
      })
  @Override
  <S extends Company> @NonNull S save(@NonNull S entity);

  /*
   * This cache implementation is only valid if the table is not
   * frequently updated since it will clear the cache at every update operation
   * If you want to be more performant you can use something like https://github.com/ms100/cache-as-multi
   * */
  @NonNull
  @CacheEvict(cacheNames = CACHE_NAME, allEntries = true)
  @Override
  <S extends Company> List<S> saveAll(@NonNull Iterable<S> entities);

  @Caching(
      evict = {
        @CacheEvict(value = CACHE_NAME, key = "{'byId', #entity.id}"),
        @CacheEvict(value = CACHE_NAME, key = "{'bySlug', #entity.slug}"),
      })
  @Override
  void delete(@NonNull Company entity);

  /*
   * This cache implementation is only valid if the table is not
   * frequently updated since it will clear the cache at every delete operation
   * If you want to be more performant you can use something like https://github.com/ms100/cache-as-multi
   * */
  @CacheEvict(cacheNames = CACHE_NAME, allEntries = true)
  @Override
  void deleteAll(@NonNull Iterable<? extends Company> entities);
}
