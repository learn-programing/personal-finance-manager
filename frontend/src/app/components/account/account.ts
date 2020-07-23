import {Currency} from './currency';
import {AccountType} from './accountType';

export class Account {
  id: number;
  name: string;
  balance = 0;
  type: AccountType;
  currency: Currency;
  editMode = false;
  lastVerificationDate: Date;
  editedAccount: Account;
  balancePLN = 0;
  bankAccountNumber: string;
  archived = false;
}

