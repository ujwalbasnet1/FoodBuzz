import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_buzz/Blocs/bloc.dart';

import 'Restaurantprofile.dart';
import 'UserProfile.dart';

class HomePage extends StatelessWidget {
  final bool isRestaurant;

  HomePage({@required this.isRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.white,
        child: FlatButton(
          child: Text('Log Out'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut());
          },
        ),
      ),
      body: isRestaurant ? RestaurantProfile() : UserProfile(),
    );
  }
}
