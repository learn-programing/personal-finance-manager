﻿import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {map} from 'rxjs/operators';

import {environment} from '../../environments/environment';
import {Subject} from 'rxjs';
import {User} from '../_models/user';

@Injectable()
export class AuthenticationService {
  private currentUserSource = new Subject<User>();

  constructor(private http: HttpClient) {
  }

  // Observable string streams
  public currentUserObservable = this.currentUserSource.asObservable();

  private updateCurrentUser(user: User) {
    this.currentUserSource.next(user);
  }

  public login(username: string, password: string) {
    return this.http.post<any>(`${environment.apiUrl}/users/authenticate`, {username: username, password: password})
      .pipe(map(user => {
        // login successful if there's a jwt token in the response
        if (user && user.token) {
          // store user details and jwt token in local storage to keep user logged in between page refreshes
          localStorage.setItem('currentUser', JSON.stringify(user));
        }

        this.updateCurrentUser(user);
        return user;
      }));
  }

  public logout() {
    // remove user from local storage to log user out
    localStorage.removeItem('currentUser');
    this.updateCurrentUser(new User());
  }
}
