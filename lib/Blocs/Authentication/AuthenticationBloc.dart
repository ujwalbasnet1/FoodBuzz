import 'package:bloc/bloc.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/AuthenticationRepo.dart';
import 'package:meta/meta.dart';

import 'AuthenticationEvent.dart';
import 'AuthenticationState.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepo authenticationRepo;

  AuthenticationBloc({@required this.authenticationRepo})
      : assert(authenticationRepo != null);

  @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final String token = await (authenticationRepo.retrieveToken());
      final bool hasToken = token != null ? true : false;
      final bool _role = await authenticationRepo.retrieveRole();

      if (hasToken) {
        yield AuthenticationAuthenticated(isRestaurant: _role);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authenticationRepo.persistToken(event.token);
      yield AuthenticationAuthenticated(isRestaurant: event.role);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authenticationRepo.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
