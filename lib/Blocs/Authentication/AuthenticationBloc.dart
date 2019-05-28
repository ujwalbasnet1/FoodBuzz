import 'package:bloc/bloc.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantRepo.dart';
import 'package:meta/meta.dart';

import 'AuthenticationEvent.dart';
import 'AuthenticationState.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final RestaurantRepo restaurantRepo;

  AuthenticationBloc({@required this.restaurantRepo})
      : assert(restaurantRepo != null);

  @override
  AuthenticationState get initialState => AuthenticationUnauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final String token = await (restaurantRepo.retrieveToken());
      final bool hasToken = token != null ? true : false;

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await restaurantRepo.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await restaurantRepo.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
