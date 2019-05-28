import 'dart:async';

import 'package:food_buzz/Blocs/Authentication/AuthenticationBloc.dart';
import 'package:food_buzz/Blocs/Authentication/AuthenticationEvent.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantRepo.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RestaurantRepo restaurantRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.restaurantRepository,
    @required this.authenticationBloc,
  })  : assert(restaurantRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await restaurantRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
