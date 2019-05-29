import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// an AppStarted event to notify the bloc that it needs to check if the user is currently authenticated or not.
// a LoggedIn event to notify the bloc that the user has successfully logged in.
// a LoggedOut event to notify the bloc that the user has successfully logged out.

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final bool role;

  LoggedIn({@required this.token, @required this.role}) : super([token, role]);

  @override
  String toString() => 'LoggedIn { token: $token , role: $role}';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
