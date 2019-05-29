import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/AuthenticationRepo.dart';
import 'package:food_buzz/UIs/Entrypage.dart';
import 'package:food_buzz/UIs/Splashpage.dart';

import 'package:food_buzz/Blocs/Authentication/AuthenticationBloc.dart';
import 'package:food_buzz/Blocs/Authentication/AuthenticationEvent.dart';
import 'package:food_buzz/Blocs/Authentication/AuthenticationState.dart';

import 'UIs/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0XFFD22030),
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: MainPage(
            authenticationRepo: new AuthenticationRepo(),
          ))),
    );
  }
}
// 0XFFD22030

class MainPage extends StatefulWidget {
  final AuthenticationRepo authenticationRepo;

  MainPage({Key key, @required this.authenticationRepo}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthenticationBloc authenticationBloc;
  AuthenticationRepo get authenticationRepo => widget.authenticationRepo;

  @override
  void initState() {
    authenticationBloc =
        AuthenticationBloc(authenticationRepo: authenticationRepo);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage(isRestaurant: state.isRestaurant);
            }
            if (state is AuthenticationUnauthenticated) {
              return EntryPage(authenticationRepo: authenticationRepo);
            }
            if (state is AuthenticationLoading) {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
