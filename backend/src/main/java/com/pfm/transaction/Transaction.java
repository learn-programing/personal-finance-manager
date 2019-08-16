package com.pfm.transaction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.pfm.history.HistoryField;
import com.pfm.history.HistoryField.SpecialFieldType;
import java.time.LocalDate;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Inheritance(strategy = InheritanceType.JOINED)

public class Transaction implements WithTransactionProperties {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  // TODO -- add Swagger annotations - type is used in getAllTransactions
  @HistoryField
  private String description;

  @HistoryField(fieldType = SpecialFieldType.CATEGORY)
  private Long categoryId;

  @HistoryField
  private LocalDate date;

  @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
  @HistoryField(fieldType = SpecialFieldType.ACCOUNT_PRICE_ENTRY)
  private List<AccountPriceEntry> accountPriceEntries;

  @JsonIgnore
  private Long userId;

  //  @Builder
  public Transaction(String description, Long categoryId, List<AccountPriceEntry> accountPriceEntries) {
    this.description = description;
    this.categoryId = categoryId;
    this.accountPriceEntries = accountPriceEntries;
  }

  //  @Builder
  public Transaction(List<AccountPriceEntry> accountPriceEntries, String description) {
    this.description = description;
    this.accountPriceEntries = accountPriceEntries;
  }

  @JsonIgnore
  @Override
  public String getClassName() {
    return this.getClass().getSimpleName();
  }
}
