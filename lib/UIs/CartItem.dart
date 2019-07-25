import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_buzz/Database/Cart.dart';

import 'package:food_buzz/Database/database.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRepos.dart';

import '../const.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  AppDatabase database;

  Future<List<Cart>> getDAO() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    var cartDAO = database.cartDao;
    if (cartDAO == null) {
      print('\n\n\nIs Null');
    } else {
      print('\n\n\nIs Not Null');
    }

    return cartDAO.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder<List<Cart>>(
        future: getDAO(),
        builder: (BuildContext context, var snapshot) {
          if (snapshot.hasData) {
            double _totalPrice = 0;

            snapshot.data.forEach((cart) {
              _totalPrice += cart.unit_price * cart.product_count;
            });

            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 98.0),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _ItemBuilder(snapshot.data[index]),
                      );
                    },
                  ),
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
                          Text(
                            'Rs.' + _totalPrice.toInt().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 44,
                  right: (MediaQuery.of(context).size.width * 0.5) - 22,
                  child: FloatingActionButton(
                    onPressed: () {
                      UserRepos()
                          .order(order(_totalPrice, snapshot.data))
                          .then((value) {
                        setState(() {
                          database.cartDao.clearCart();
                          getDAO();
                        });
                      });
                    },
                    child: Icon(Icons.add, size: 32),
                  ),
                )
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

  Widget _ItemBuilder(Cart item) {
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
                (item.picture.contains('http'))
                    ? item.picture
                    : Constant.baseURLB + item.picture,
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
                        Text(item.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato')),
                        Text(item.restaurant_name,
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
                          'Rs.' + item.unit_price.toString(),
                          style: TextStyle(color: Colors.black45),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black26)),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  if (item.product_count > 1)
                                    await database.cartDao
                                        .decreaseCartItem(item.id);
                                  else
                                    await database.cartDao.deleteCart(item.id);

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black45,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                item.product_count.toString(),
                                style: TextStyle(color: Colors.black45),
                              ),
                              SizedBox(width: 12),
                              InkWell(
                                onTap: () async {
                                  await database.cartDao
                                      .increaseCartItem(item.id);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black45,
                                ),
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
          child: InkWell(
            onTap: () async {
              await database.cartDao.deleteCart(item.id);
              setState(() {});
            },
            child: Icon(
              Icons.close,
              color: Colors.black45,
              size: 16,
            ),
          ),
          right: 16,
          top: 8,
        ),
      ],
    );
  }

  dynamic order(double totalPrice, List<Cart> cartList) {
    var list = "[";

    cartList.forEach((cart) {
      list += cart.toJSONString() + ",";
    });

    list = list.substring(0, list.length - 1);

    list += "]";

    dynamic toJSON = {'total_price': totalPrice.toString(), 'cart': list};

    print(toJSON);
//
//    dynamic cartJSON = {};
//
//    int i = 0;
//    cartList.forEach((cartItem) {
//      i++;
//      cartJSON = {...cartJSON, i.toString(): cartItem.toJSON()};
//    });
//
//    toJSON = {...toJSON, 'food_items': cartJSON};

    return toJSON;
  }
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
