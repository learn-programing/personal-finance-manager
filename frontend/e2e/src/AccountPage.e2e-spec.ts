import {AccountsPage} from './AccountPage.po';
import {LoginPage} from './LoginPage.po';
import {RegisterPage} from './RegisterPage.po';
import {v4 as uuid} from 'uuid';
import {CategoryPage} from './CategoryPage.po';
import {TransactionAndFilterPage} from './TransactionPage.po';

describe('Accounts page tests', () => {
  const accountPage = new AccountsPage();
  const categoryPage = new CategoryPage();
  const transactionPage = new TransactionAndFilterPage();

  beforeAll(async () => {
    const registerPage = new RegisterPage();
    const username = 'Username_' + uuid();
    const password = 'Password_' + uuid();
    await registerPage.registerUser('FirstName', 'LastName', username, password);

    const loginPage = new LoginPage();
    await loginPage.loginAs(username, password);
  });

  beforeEach(async () => {

    await transactionPage.navigateTo();
    await transactionPage.removeAllTransactions();

    await accountPage.navigateTo();
    await accountPage.removeAllAccounts();

    await categoryPage.navigateTo();
    await categoryPage.removeAllCategories();

    accountPage.navigateTo();
  });

  it('should display correct English descriptions', () => {

    // then
    expect(accountPage.refreshAccountsButton().getText()).toEqual('Refresh');
    expect(accountPage.addAccountButton().getText()).toEqual('Add Account');
    expect(accountPage.nameHeader().getText()).toEqual('Name ▲');
    expect(accountPage.balanceHeader().getText()).toEqual('Balance');
  });

  it('should add account', () => {
    // given
    const accountName = 'First Test Account';

    // when
    accountPage.addAccount(accountName, '141231.53');

    // then
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), accountName);
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '141,231.53');
  });

  it('should update account', () => {
    // when
    const accountName = 'First Updated Test Account';
    accountPage.addAccount('First Test Account', '141231.53');

    // given
    accountPage.updateAccount(accountName, '231.5');

    // then
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), accountName);
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '231.50');
  });

  it('should delete account', () => {
    // when
    accountPage.addAccount('Account to delete', '0');

    // given
    accountPage.deleteAccount(accountPage.accountRows().first());

    // then
    accountPage.assertNumberOfAccounts(0);
  });

  it('should check balance PLN', () => {
    // when
    const accountName = 'First Balance PLN Check';
    // given
    accountPage.addAccount(accountName, '250.20');
    // then
    accountPage.assertBalanceOfAllAccounts();
  });

  it('should check balance PLN with balance PLN from Account Type Table', () => {
      // when
      const accountName = 'Balance PLN from Account Type Check';
      // given
      accountPage.addAccountWithAccountTypeAndCurrency(accountName, 'Investment', '250.20', 'GBP');
      // then
      accountPage.assertBalanceOfAllAccounts();
      accountPage.assertBalanceOfAllAccountsType();
    });



  it('should check account balance currency with  box currencies balance currency', () => {
    // given
    accountPage.addAccountWithCurrency('Balance currency EUR', '300.25', 'EUR');
    accountPage.addAccountWithCurrency('Balance currency GBP', '123.50', 'GBP');
    accountPage.addAccountWithCurrency('Balance currency PLN', '1250.25', 'PLN');
    accountPage.addAccountWithCurrency('Balance currency USD', '525.75', 'USD');

    // then
    const balanceEUR = accountPage.balanceOfEURAccount().getText();
    const balanceGBP = accountPage.balanceOfGBPAccount().getText();
    const balancePLN = accountPage.balanceOfPLNAccount().getText();
    const balanceUSD = accountPage.balanceOfUSDAccount().getText();
    accountPage.assertAccountBalance(accountPage.accountRows().get(0), balanceEUR);
    accountPage.assertAccountBalance(accountPage.accountRows().get(1), balanceGBP);
    accountPage.assertAccountBalance(accountPage.accountRows().get(2), balancePLN);
    accountPage.assertAccountBalance(accountPage.accountRows().get(3), balanceUSD);
  });


  it('should check box currencies balance PLN', () => {
    // given
    accountPage.addAccountWithCurrency('Balance currency EUR', '300.25', 'EUR');
    accountPage.addAccountWithCurrency('Balance currency GBP', '123.50', 'GBP');
    accountPage.addAccountWithCurrency('Balance currency PLN', '1250.25', 'PLN');
    accountPage.addAccountWithCurrency('Balance currency USD', '525.75', 'USD');

    // then
    accountPage.assertAccountBalancePLNOfEUR('1,273.06');
    accountPage.assertAccountBalancePLNOfGBP('616.27');
    accountPage.assertAccountBalancePLNOfPLN('1,250.25');
    accountPage.assertAccountBalancePLNOfUSD('1,882.19');
    accountPage.assertAccountBalancePLNSummary('5,021.76');
  });

  it('should check box account type balance PLN', () => {
    // given
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Credit', 'Credit', '300.25', 'EUR');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Investment', 'Investment', '123.50', 'GBP');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Personal', 'Personal', '1250.25', 'PLN');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Saving', 'Saving', '525.75', 'USD');

    // then
    accountPage.assertNumberOfAccounts(4);
    accountPage.assertAccountBalancePLNOfEUR('1,273.06');
    accountPage.assertAccountBalancePLNOfGBP('616.27');
    accountPage.assertAccountBalancePLNOfPLN('1,250.25');
    accountPage.assertAccountBalancePLNOfUSD('1,882.19');
    accountPage.assertAccountBalancePLNSummary('5,021.76');
    accountPage.assertAccountBalancePLNOfCreditAccount('1,273.06');
    accountPage.assertAccountBalancePLNOfInvestmentAccount('616.27');
    accountPage.assertAccountBalancePLNOfPersonalAccount('1,250.25');
    accountPage.assertAccountBalancePLNOfSavingAccount('1,882.19');
    accountPage.assertBalanceOfAllAccounts();
    accountPage.assertBalanceOfAllAccountsType();

  });

  it('should check balance verification date', () => {
   // when
    const accountName = 'First confirm balance';
    accountPage.addAccountWithCurrency(accountName, '125.75', 'USD');

    // given
    accountPage.confirmBalance(accountPage.accountRows().first());
     // then
    accountPage.assertAccountBalancePLNOfUSD('450.19');
    const todayDate = new Date().toISOString().split('T')[0];
    accountPage.assertBalanceVerificationDate(accountPage.accountRows().first(), todayDate);
  });

  it('should make active accounts', () => {
    // when
    const accountName = 'First archive account make active';
    accountPage.addAccountWithCurrency(accountName, '125.75', 'USD');
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), accountName);
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '125.75');
    accountPage.assertAccountBalancePLNOfUSD('450.19');
    accountPage.archiveBalance(accountPage.accountRows().first());
    accountPage.assertNumberOfAccounts(0);
    accountPage.archiveAccountsShow();
    accountPage.assertNumberOfAccounts(1);

    // given
    accountPage.makeActiveAccounts(accountPage.accountRows().first());

    // then
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), accountName);
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '125.75');
    accountPage.assertAccountBalancePLNOfUSD('450.19');
  });

  it('should archive accounts and show archived accounts', () => {
    // when
    const accountName = 'First archive account';
    accountPage.addAccountWithCurrency(accountName, '125.75', 'USD');
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), accountName);
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '125.75');
    accountPage.assertAccountBalancePLNOfUSD('450.19');
    accountPage.archiveBalance(accountPage.accountRows().first());
    accountPage.assertNumberOfAccounts(0);

    // given
    accountPage.archiveAccountsShow();

    // then
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), accountName);
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '125.75');
    accountPage.assertAccountBalancePLNOfUSD('450.19');
    accountPage.makeActiveAccounts(accountPage.accountRows().first());
  });

  it('should check account totals  by account type', () => {
    // given
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Credit_1', 'Credit', '300.25', 'EUR');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Credit_2', 'Credit', '123.50', 'GBP');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account type Credit_3', 'Credit', '-100.50', 'PLN');

    // then
    accountPage.assertNumberOfAccounts(3);
    accountPage.assertAccountBalancePLNOfEUR('1,273.06');
    accountPage.assertAccountBalancePLNOfGBP('616.27');
    accountPage.assertAccountBalancePLNOfPLN('-100.50');
    accountPage.assertAccountBalancePLNOfCreditAccount('1,788.83');
    accountPage.assertBalanceOfAllAccounts();
    accountPage.assertBalanceOfAllAccountsType();
  });

  it('should check account totals  by currency', () => {
    // given
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account GBP_1', 'Investment', '300.25', 'GBP');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account GBP_2', 'Personal', '123.50', 'GBP');
    accountPage.addAccountWithAccountTypeAndCurrency('Balance account GBP_3', 'Saving', '-100.50', 'GBP');

    // then
    accountPage.assertNumberOfAccounts(3);
    accountPage.assertAccountBalancePLNOfGBP('1,613.02');
    accountPage.assertAccountBalancePLNOfInvestmentAccount('1,498.25');
    accountPage.assertAccountBalancePLNOfPersonalAccount('616.27');
    accountPage.assertAccountBalancePLNOfSavingAccount('-501.50');
    accountPage.assertBalanceOfAllAccounts();
    accountPage.assertBalanceOfAllAccountsType();
  });

  it('should increase the account balance by the inserted transaction' , () => {
    // given
    categoryPage.navigateTo();
    categoryPage.addCategory('Salary', 'Main Category');
    categoryPage.assertMessage('Category added');
    categoryPage.assertNumberOfCategories(1);
    categoryPage.assertCategoryName(categoryPage.categoryRowsAll().first(), 'Salary');
    categoryPage.assertParentCategory(categoryPage.categoryRowsAll().first(), 'Main Category');

    accountPage.navigateTo();
    accountPage.addAccountWithCurrency('ING', '9750.25', 'PLN');
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), 'ING');
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '9,750.25');
    accountPage.assertAccountBalancePLNSummary('9,750.25');


    // when
    transactionPage.navigateTo();
    transactionPage.addTransaction('26/11/2019', 'wages', '7850.25', null, 'ING', null, 'Salary');
    expect(transactionPage.transactionRows().count()).toEqual(1);

    // then
    accountPage.navigateTo();
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), 'ING');
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '17,600.50');
    accountPage.assertAccountBalancePLNSummary('17,600.50');

  });

  xit('should reduce the account balance by the minus transaction inserted' , () => {
    // given
    categoryPage.navigateTo();
    categoryPage.addCategory('Car', 'Main Category');
    categoryPage.assertMessage('Category added');
    categoryPage.assertNumberOfCategories(1);
    categoryPage.addCategory('Oil', 'Car');
    categoryPage.assertMessage('Category added');
    categoryPage.assertNumberOfCategories(2);

    accountPage.navigateTo();
    accountPage.addAccountWithCurrency('ING', '8269.52', 'PLN');
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), 'ING');
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '8,269.52');
    accountPage.assertAccountBalancePLNSummary('8,269.52');

    // when
    transactionPage.navigateTo();
    transactionPage.addTransaction('09/01/2020', 'petrol', '-250', null, 'ING', null, 'Oil');
    expect(transactionPage.transactionRows().count()).toEqual(1);
    transactionPage.assertPrices('-250.00 PLN', null);

    // then
    accountPage.navigateTo();
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), 'ING');
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '8,018.96');
    accountPage.assertAccountBalancePLNSummary('8,018.96');

  });

  xit('should display the account balance minus the inserted transaction minus' , () => {
    // given
    categoryPage.navigateTo();
    categoryPage.addCategory('Car', 'Main Category');
    categoryPage.assertMessage('Category added');
    categoryPage.assertNumberOfCategories(1);
    categoryPage.addCategory('Oil', 'Car');
    categoryPage.assertMessage('Category added');
    categoryPage.assertNumberOfCategories(2);

    accountPage.navigateTo();
    accountPage.addAccountWithCurrency('PKO', '0', 'EUR');
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), 'PKO');
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '0.00');
    accountPage.assertAccountBalancePLNSummary('0.00');

    // when
    transactionPage.navigateTo();
    transactionPage.addTransaction('09/01/2020', 'petrol', '-32', null, 'PKO', null, 'Oil');
    expect(transactionPage.transactionRows().count()).toEqual(1);
    transactionPage.assertPrices('-32.00 EUR (-135.68 PLN)', null);

    // then
    accountPage.navigateTo();
    accountPage.assertNumberOfAccounts(1);
    accountPage.assertAccountName(accountPage.accountRows().first(), 'PKO');
    accountPage.assertAccountBalance(accountPage.accountRows().first(), '-32.75');
    accountPage.assertAccountBalancePLNSummary('-138.86');
  });


});
