package com.mycompany.microservice.api.repositories;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.Repository;

@NoRepositoryBean
public interface CustomBaseRepository<T, ID> extends Repository<T, ID> {
  T getById(ID id);

  T save(ID id);
}
