import 'package:flutter/material.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantProfileRepo.dart';

import 'Restaurantprofile.dart';
import 'UserProfile.dart';

class HomePage extends StatelessWidget {
  final bool isRestaurant;

  HomePage({@required this.isRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isRestaurant
          ? RestaurantProfile(
              repo: RestaurantProfileRepo(
                  authenticationRepo: AuthenticationRepo()))
          : UserProfile(),
    );
  }
}
