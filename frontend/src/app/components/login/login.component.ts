﻿import {Component, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {first} from 'rxjs/operators';
import {AuthenticationService} from '../../authentication/authentication.service';

@Component({templateUrl: 'login.component.html'})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  loading = false;
  submitted = false;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService
  ) {
  }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });

  }

  // convenience getter for easy access to form fields
  get f() {
    return this.loginForm.controls;
  }

  onSubmit() {
    this.submitted = true;

    if (this.loginForm.invalid) {
      return;
    }

    const returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/transactions';

    this.loading = true;
    this.authenticationService.login(this.username(), this.password())
        .pipe(first())
        .subscribe(
          data => {
            this.router.navigate([returnUrl]);
          },
          error => {
            this.loading = false;
          });
  }

  private password() {
    return this.f.password.value;
  }

  private username() {
    return this.f.username.value;
  }

}
