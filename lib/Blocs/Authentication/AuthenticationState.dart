import 'package:equatable/equatable.dart';

// A user's authentication state can be one of the following:

//     uninitialized - waiting to see if the user is authenticated or not on app start.
//     loading - waiting to persist/delete a token
//     authenticated - successfully authenticated
//     unauthenticated - not authenticated

// Each of these states will have an implication on what the user sees.

// For example:

//     if the authentication state was uninitialized, the user might be seeing a splash screen.
//     if the authentication state was loading, the user might be seeing a progress indicator.
//     if the authentication state was authenticated, the user might see a home screen.
//     if the authentication state was unauthenticated, the user might see a login form.

abstract class AuthenticationState extends Equatable {
  String toString();
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'Authentication Uninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
