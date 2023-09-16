package com.mycompany.microservice.api.entities;

import static com.mycompany.microservice.api.entities.ApiKey.TABLE_NAME;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mycompany.microservice.api.entities.base.BaseEntity;
import io.hypersistence.utils.hibernate.id.BatchSequenceGenerator;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;
import java.io.Serial;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@SuperBuilder
@Table(name = TABLE_NAME, schema = "public")
public class ApiKey extends BaseEntity {
  public static final String TABLE_NAME = "api_key";

  @Serial private static final long serialVersionUID = -3552577854495026179L;

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "api_key")
  @GenericGenerator(
      name = "api_key",
      type = BatchSequenceGenerator.class,
      parameters = {
        @Parameter(name = "sequence", value = "api_key_id_seq"),
        @Parameter(name = "fetch_size", value = "1")
      })
  private Long id;

  @JoinColumn(nullable = false)
  private Long companyId;

  @Column(nullable = false)
  private String name;

  @JsonIgnore
  @Column(unique = true, nullable = false)
  private String key;

  @Column(nullable = false)
  private Boolean isActive;

  @Override
  public Long getId() {
    return this.id;
  }

  @Override
  public String toString() {
    return "Apikey{"
        + "id="
        + this.id
        + ", companyId="
        + this.companyId
        + ", name='"
        + this.name
        + "', isActive="
        + this.isActive
        + "', createdBy="
        + this.getCreatedBy()
        + ", updatedBy="
        + this.getUpdatedBy()
        + "', createdAt="
        + this.getCreatedAt()
        + ", updatedAt="
        + this.getUpdatedAt()
        + '}';
  }

  @Override
  public boolean equals(final Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof final ApiKey other)) {
      return false;
    }
    return this.getId() != null && this.getId().equals(other.getId());
  }

  @Override
  public int hashCode() {
    return this.getClass().hashCode();
  }
}
