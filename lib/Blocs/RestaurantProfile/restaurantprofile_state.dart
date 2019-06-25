import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RestaurantprofileState extends Equatable {
  RestaurantprofileState([List props = const []]) : super(props);
}

class InitialRestaurantprofileState extends RestaurantprofileState {}
