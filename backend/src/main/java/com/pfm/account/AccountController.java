package com.pfm.account;

import com.pfm.Messages;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("accounts")
@CrossOrigin
public class AccountController {

  private AccountService accountService;
  private AccountValidator accountValidator;

  @GetMapping(value = "/{id}")
  public ResponseEntity getAccountById(@PathVariable long id) {
    log.info("Retrieving account with ID = ", id);
    Optional<Account> account = accountService.getAccountById(id);

    if (account.isPresent()) {
      log.info(Messages.ACCOUNT_WITH_ID + id + Messages.NOT_FOUND);
      return new ResponseEntity<>(account.get(), HttpStatus.OK);
    }
    log.info(Messages.ACCOUNT_WITH_ID + id + " successfully retrieved");
    return ResponseEntity.notFound().build();
  }

  @GetMapping
  public ResponseEntity<List<Account>> getAccounts() {
    log.info("Retrieving all accounts from database...");
    List<Account> accounts = accountService.getAccounts();
    return new ResponseEntity<>(accounts, HttpStatus.OK);
  }

  @PostMapping
  public ResponseEntity addAccount(@RequestBody Account account) {
    log.info("Saving account to the database");
    if (account.getId() != null && accountService.idExist(account.getId())) {
      return ResponseEntity.badRequest().body(Messages.ADD_ACCOUNT_PROVIDED_ID_ALREADY_EXIST);
    }
    List<String> validationResult = accountValidator.validate(account);
    if (!validationResult.isEmpty()) {
      log.error(Messages.ACCOUNT_NOT_VALID);
      return ResponseEntity.badRequest().body(validationResult);
    }
    Account createdAccount = accountService.addAccount(account);
    log.info("Saving account to the database was successful");
    return new ResponseEntity<>(createdAccount.getId(), HttpStatus.OK);
  }

  @PutMapping(value = "/{id}")
  public ResponseEntity updateAccount(@PathVariable long id, @RequestBody Account account) {
    if (!accountService.idExist(id)) {
      log.info("Updating account : " + Messages.UPDATE_ACCOUNT_NO_ID_OR_ID_NOT_EXIST);
      return ResponseEntity.badRequest().body(Messages.UPDATE_ACCOUNT_NO_ID_OR_ID_NOT_EXIST);
    }
    account.setId(id);
    log.info("Updating account with ID = ", id, " in the database");
    List<String> validationResult = accountValidator.validate(account);

    if (!validationResult.isEmpty()) {
      log.error(Messages.ACCOUNT_NOT_VALID);
      return ResponseEntity.badRequest().body(validationResult);
    }
    Account updatedAccount = accountService.updateAccount(id, account);
    log.info(Messages.ACCOUNT_WITH_ID + id + " successfully updated");
    return new ResponseEntity<>(updatedAccount, HttpStatus.OK);
  }

  @DeleteMapping(value = "/{id}")
  public ResponseEntity<Long> deleteAccount(@PathVariable long id) {
    log.info("Attempting to delete account with ID = " + id);

    if (!accountService.getAccountById(id).isPresent()) {
      log.error(Messages.ACCOUNT_WITH_ID + id + Messages.NOT_FOUND);
      return ResponseEntity.notFound().build();
    }
    accountService.deleteAccount(id);
    log.info(Messages.ACCOUNT_WITH_ID + id, " deleted successfully");
    return new ResponseEntity<>(id, HttpStatus.OK);
  }
}