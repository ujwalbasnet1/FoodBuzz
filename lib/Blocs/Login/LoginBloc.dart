import 'dart:async';

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

        authenticationBloc
            .dispatch(LoggedIn(token: token, role: event.isRestaurant));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
