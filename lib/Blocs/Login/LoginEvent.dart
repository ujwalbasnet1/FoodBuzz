import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final bool isRestaurant;

  LoginButtonPressed(
      {@required this.username,
      @required this.password,
      @required this.isRestaurant})
      : super([username, password, isRestaurant]) {
    print('LoginButtonPressed { username: $username, password: $password }');
  }

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
