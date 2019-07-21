import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_buzz/Models/Cart.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/Repo/UserRepositories/User_RestaurantProfileRepo.dart';

import '../const.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Cart>(
        future: User_RestaurantProfileRepo(
          authenticationRepo: AuthenticationRepo(),
        ).getFromCart(),
        builder: (BuildContext context, var snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: snapshot.data.foodItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _ItemBuilder(snapshot.data.foodItems[index]),
                    );
                  },
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 64,
                      width: MediaQuery.of(context).size.width - 16,
                      color: Color(0XFFD22030),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 24,
                                fontFamily: 'Lato'),
                          ),
                          Container(
                            width: 3,
                            height: 64,
                            color: Colors.white,
                          ),
                          Text(
                            'Rs.' + snapshot.data.totalPrice.toInt().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                    )),
              ],
            );
          }
          return Center(
              child: Container(
                  height: 100, width: 100, child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

Widget _ItemBuilder(CartItemModel item) {
  return Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Color(0XFFe5e9ea).withOpacity(0.6),
          borderRadius: BorderRadius.circular(1),
        ),
        padding: EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
        height: 96,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              (item.foodItem.picture.contains('http'))
                  ? item.foodItem.picture
                  : Constant.baseURLB + item.foodItem.picture,
              width: 64,
              height: 72,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.foodItem.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lato')),
                      Text(item.foodItem.restaurantName,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontFamily: 'Lato')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rs.' + item.foodItem.price,
                        style: TextStyle(color: Colors.black45),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.black26)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove,
                              color: Colors.black45,
                            ),
                            SizedBox(width: 12),
                            Text(
                              item.count.toString(),
                              style: TextStyle(color: Colors.black45),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.add,
                              color: Colors.black45,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        child: Icon(
          Icons.close,
          color: Colors.black45,
          size: 16,
        ),
        right: 16,
        top: 8,
      ),
    ],
  );
}

/**
 *  Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: MediaQuery.of(context).size.width - 16,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XFFD22030),
                  ),
                  child: Center(
                    child: Text(
                      'Check Out',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato'),
                    ),
                  ),
                ),
 */
