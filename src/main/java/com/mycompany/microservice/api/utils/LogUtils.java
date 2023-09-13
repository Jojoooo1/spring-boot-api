package com.mycompany.microservice.api.utils;

import com.mycompany.microservice.api.entities.base.BaseEntity;
import java.util.List;
import lombok.experimental.UtilityClass;
import org.springframework.lang.NonNull;

@UtilityClass
public class LogUtils {

  public static String NULL = "null";

  public static String logId(final BaseEntity entity) {
    return entity != null && entity.getId() != null ? entity.getId().toString() : NULL;
  }

  public static String logIds(@NonNull final List<BaseEntity> entities) {
    if (entities == null || entities.isEmpty()) {
      return List.of().toString();
    }
    return entities.stream()
        .map(e -> e.getId() != null ? e.getId().toString() : NULL)
        .toList()
        .toString();
  }
}
