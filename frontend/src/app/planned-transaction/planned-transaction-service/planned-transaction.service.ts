import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {PlannedTransactionResponse} from './planned-transaction-response';
import {ServiceBase} from '../../helpers/service-base';
import {Transaction} from '../../components/transaction/transaction';

const PATH = 'transactions';

@Injectable({
  providedIn: 'root'
})
export class PlannedTransactionService extends ServiceBase {

  constructor(http: HttpClient) {
    super(http);
  }

  private static plannedTransactionToPlannedTransactionRequest(plannedTransaction: Transaction) {
    const result = {
      description: plannedTransaction.description,
      categoryId: plannedTransaction.category.id,
      accountPriceEntries: [],
      date: plannedTransaction.date,
      // isPlanned: plannedTransaction.isPlanned,
    };

    for (const entry of plannedTransaction.accountPriceEntries) {
      if (entry.account === undefined || entry.price === undefined) {
        continue;
      }

      result.accountPriceEntries.push(
        {
          accountId: entry.account.id,
          price: entry.price
        }
      );
    }

    return result;
  }

  getPlannedTransactions(): Observable<PlannedTransactionResponse[]> {
    return this.http.get<PlannedTransactionResponse[]>(PlannedTransactionService.apiUrl(PATH));
  }

  getPlannedTransaction(id: number): Observable<PlannedTransactionResponse> {
    return this.http.get<PlannedTransactionResponse>(ServiceBase.apiUrl(PATH, id));
  }

  addPlannedTransaction(plannedTransaction: Transaction): Observable<any> {
    const categoryRequest = PlannedTransactionService.plannedTransactionToPlannedTransactionRequest(plannedTransaction);
    return this.http.post<any>(ServiceBase.apiUrl(PATH), categoryRequest, this.contentType);
  }

  deleteTransaction(id: number): Observable<any> {
    return this.http.delete<any>(ServiceBase.apiUrl(PATH, id));
  }

  editTransaction(category: Transaction): Observable<any> {
    const categoryRequest = PlannedTransactionService.plannedTransactionToPlannedTransactionRequest(category);
    return this.http.put<Transaction>(ServiceBase.apiUrl(PATH, category.id), categoryRequest, this.contentType);
  }
}