import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_buzz/Blocs/bloc.dart';

import 'package:food_buzz/Repo/AuthenticationRepo.dart';

import 'package:food_buzz/UIs/Entrypage.dart';
import 'package:food_buzz/UIs/Splashpage.dart';
import 'package:food_buzz/UIs/HomePage.dart';
import 'package:food_buzz/animationTest.dart';

import 'package:shimmer/shimmer.dart';

import 'ImageUpload.dart';
import 'UIs/AddDish.dart';
import 'UIs/CartItem.dart';
import 'UIs/Postitem.dart';
import 'UIs/RestaurantRegistration.dart';
import 'UIs/Restaurantprofile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MainPage(
    //   authenticationRepo: new AuthenticationRepo(),
    // );

    double _width = 300;

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato'),
      home: SafeArea(child: Scaffold(body: AddDish())),
    );
  }
}
// 0XFFD22030

// PostItem(
//           ago: '5hr',
//           img: 'https://i.pinimg.com/736x/b8/84/68/b88468cd7b9949319362eef162fcfae6--weheartit-comment.jpg',
//           name: 'Samjhana Pokharel',
//         )

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
        home: Scaffold(
          body: SafeArea(
            child: BlocBuilder<AuthenticationEvent, AuthenticationState>(
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
        ),
      ),
    );
  }
}
