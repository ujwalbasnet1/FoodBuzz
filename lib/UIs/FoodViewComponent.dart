import 'package:flutter/material.dart';
import 'package:food_buzz/Database/Cart.dart';
import 'package:food_buzz/Database/database.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRepos.dart';

class FoodViewComponent extends StatefulWidget {
  final RecommendationItemModel data;
  // imageURL, restaurantName, price, productName, productID, restaurantID

  FoodViewComponent({this.data});

  @override
  _FoodViewComponentState createState() => _FoodViewComponentState();
}

class _FoodViewComponentState extends State<FoodViewComponent> {
  bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.data.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.data.restaurantName,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Rs. ' + widget.data.price.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFD22030),
                    ),
                  ),
                  SizedBox(height: 5),
                  Image.network(
                    widget.data.picture,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Icon(Icons.shopping_cart,
                    color: _addedToCart ? Color(0XFFD22030) : Colors.grey),
                onPressed: () async {
                  setState(() {
                    _addedToCart = true;
                  });

                  var database = await $FloorAppDatabase
                      .databaseBuilder('app_database.db')
                      .build();

                  var cartDAO = database.cartDao;

                  cartDAO
                      .insertCart(
                        Cart.withNoID(
                          product_id: widget.data.id,
                          restaurant_id: widget.data.restaurantID,
                          product_count: 1,
                          unit_price: double.parse(widget.data.price),
                          picture: widget.data.picture,
                          name: widget.data.name,
                          restaurant_name: widget.data.restaurantName,
                        ),
                      )
                      .then((val) => print('Successfully Added'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
