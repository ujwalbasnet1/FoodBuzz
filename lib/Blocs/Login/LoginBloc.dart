import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:food_buzz/Blocs/Authentication/AuthenticationBloc.dart';
import 'package:food_buzz/Blocs/Authentication/AuthenticationEvent.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/AuthenticationRepo.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepo authenticationRepo;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationRepo,
    @required this.authenticationBloc,
  })  : assert(authenticationRepo != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await authenticationRepo.authenticate(
            username: event.username,
            password: event.password,
            isRestaurant: event.isRestaurant);

        // yield ();
        authenticationBloc
            .dispatch(LoggedIn(token: token, role: event.isRestaurant));

        yield LoginSuccess();
      } catch (error) {
        print('\n\n\n\n\n Error is this okay' + error.toString());
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
