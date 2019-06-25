import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget x = Stack(
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
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG9CugWJ5CSnVLEwa4G4d1nhsS8rGHLvVXcUKsK3WcGkvyaaI8cg',
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
                        Text('Crispy Chicken',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato')),
                        Text('restaurant name',
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
                          'Rs. 200',
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
                                '5',
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

    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: x,
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
                    'Rs. 800',
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
