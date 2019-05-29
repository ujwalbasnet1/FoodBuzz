import 'package:flutter/material.dart';

import 'Restaurantprofile.dart';
import 'UserProfile.dart';

class HomePage extends StatelessWidget {
  final bool isRestaurant;

  HomePage({@required this.isRestaurant});

  @override
  Widget build(BuildContext context) {
    return isRestaurant ? RestaurantProfile() : UserProfile();
  }
}
