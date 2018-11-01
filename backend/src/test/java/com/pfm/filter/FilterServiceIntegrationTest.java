package com.pfm.filter;

import static com.pfm.helpers.TestAccountProvider.accountMbankBalance10;
import static com.pfm.helpers.TestCategoryProvider.categoryCar;
import static com.pfm.helpers.TestFilterProvider.filterFoodExpenses;
import static com.pfm.helpers.TestFilterProvider.filterHomeExpensesUpTo200;
import static com.pfm.helpers.TestUsersProvider.userZdzislaw;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import com.pfm.account.Account;
import com.pfm.account.AccountService;
import com.pfm.auth.UserService;
import com.pfm.category.Category;
import com.pfm.category.CategoryService;
import java.util.Collections;
import org.flywaydb.core.Flyway;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FilterServiceIntegrationTest {

  @Autowired
  protected Flyway flyway;

  @Autowired
  private AccountService accountService;

  @Autowired
  private CategoryService categoryService;

  @Autowired
  private FilterService filterService;

  @Autowired
  private UserService userService;

  private long userId;

  @Before
  public void before() {
    flyway.clean();
    flyway.migrate();
    userId = userService.registerUser(userZdzislaw()).getId();
  }

  @Test
  public void shouldCheckIfFilterExistByAccountId() {

    //given
    Account account = accountMbankBalance10();
    long accountId = accountService.addAccount(userId, account).getId();

    Filter filter = filterFoodExpenses();
    filter.setAccountIds(Collections.singletonList(accountId));
    long filterId = filterService.addFilter(userId, filter).getId();

    //when
    assertTrue(filterService.filterExistByAccountId(accountId));

    filterService.deleteFilter(filterId);

    assertFalse(filterService.filterExistByAccountId(accountId));
  }

  @Test
  public void shouldCheckIfFilterExistByCategoryId() {

    //given
    Category category = categoryCar();
    Long categoryId = categoryService.addCategory(category, userId).getId();

    Filter filter = filterHomeExpensesUpTo200();
    filter.setCategoryIds(Collections.singletonList(categoryId));
    long filterId = filterService.addFilter(userId, filter).getId();

    //when
    assertTrue(filterService.filterExistByCategoryId(categoryId));

    filterService.deleteFilter(filterId);

    assertFalse(filterService.filterExistByCategoryId(categoryId));
  }

}
