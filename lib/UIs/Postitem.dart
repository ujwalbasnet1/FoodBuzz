import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String img, name, ago;

  PostItem({@required this.name, @required this.img, @required this.ago});

  @override
  Widget build(BuildContext context) {
    Widget circularimg = Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(img))));

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    circularimg,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                fontFamily: 'Cursive'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            ago,
                            style: TextStyle(fontSize: 12, fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.whatshot,
                    size: 36,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Food is happiness',
                style: TextStyle(fontSize: 14, fontFamily: 'Play'),
                maxLines: 2,
              ),
            ),
            Image.network(
              img,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            )
          ],
        ),
      ),
    );
  }
}
