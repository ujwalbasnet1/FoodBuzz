import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RestaurantprofileBloc extends Bloc<RestaurantprofileEvent, RestaurantprofileState> {
  @override
  RestaurantprofileState get initialState => InitialRestaurantprofileState();

  @override
  Stream<RestaurantprofileState> mapEventToState(
    RestaurantprofileEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
