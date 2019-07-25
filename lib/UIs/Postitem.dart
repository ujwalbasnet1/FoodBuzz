import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRepos.dart';

import '../const.dart';

class PostItem extends StatefulWidget {
  final FeedItemModel data;

  PostItem({@required this.data});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem>
    with SingleTickerProviderStateMixin {
  GlobalKey _imageContainerKey = GlobalKey();

  Animation<double> animation;
  Animation curveAnimation;
  AnimationController animationController;

  Size postedImageSize;
  bool isLit = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    curveAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutBack);

    animation = Tween<double>(begin: 0, end: 1).animate(curveAnimation)
      ..addListener(() {
        setState(() {});
      });

    postedImageSize = new Size(0, 0);
    isLit = widget.data.liked;
  }

  @override
  Widget build(BuildContext context) {
    double _height = postedImageSize.height ?? 0;

    String _img = widget.data.profilePicture.contains('http')
        ? widget.data.profilePicture
        : Constant.baseURLB + widget.data.profilePicture;

    Widget circularImg = Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(_img))));

    return Container(
      margin: EdgeInsets.all(6),
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
                    circularImg,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            widget.data.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                fontFamily: 'Cursive'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.data.time,
                            style: TextStyle(fontSize: 12, fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    print('Button CLicked');
                    setState(() {
                      isLit = !isLit;
                    });
                  },
                  child: IconButton(
                    color: isLit ? Colors.deepOrange : Colors.black,
                    icon: Icon(
                      Icons.whatshot,
                      size: 36,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(widget.data.dishName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            InkWell(
                onDoubleTap: () {
                  UserRepos().like(widget.data.id).then((value) {
                    setState(() {
                      animationController.reset();
                      animationController.forward();
                      Future.delayed(Duration(milliseconds: 1000), () {
                        animationController.reset();
                      });
                    });

                    setState(() {
                      isLit = true;

                      postedImageSize = _imageContainerKey.currentContext.size;
                      _height = postedImageSize.height;
                    });
                  });
                },
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      widget.data.dishPicture.contains('http')
                          ? widget.data.dishPicture
                          : Constant.baseURLB + widget.data.dishPicture,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                      key: _imageContainerKey,
                    ),
                    Container(
                      height: _height,
                      color: Colors.black.withOpacity(animation.value * 0.2),
                    ),
                    Positioned(
                      top: _height * 0.5 - 48 * animation.value,
                      right: MediaQuery.of(context).size.width * 0.5 -
                          48 * animation.value,
                      child: Icon(
                        Icons.whatshot,
                        size: 96 * animation.value,
                        color: Colors.orange,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: widget.data.likes > 0
                  ? Row(
                      children: <Widget>[
                        Icon(
                          Icons.whatshot,
                          size: 16,
                          color: isLit
                              ? Colors.deepOrange.withOpacity(0.75)
                              : Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.data.likes.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              color: isLit
                                  ? Colors.deepOrange.withOpacity(0.75)
                                  : Colors.grey),
                        )
                      ],
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
