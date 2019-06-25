import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final String img, name, ago;

  PostItem({@required this.name, @required this.img, @required this.ago});

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
  }

  @override
  Widget build(BuildContext context) {
    double _height = postedImageSize.height ?? 0;

    Widget circularImg = Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(widget.img))));

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
                    circularImg,
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                fontFamily: 'Cursive'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.ago,
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Food is happiness',
                style: TextStyle(fontSize: 14, fontFamily: 'Play'),
                maxLines: 2,
              ),
            ),
            InkWell(
                onDoubleTap: () {
                  setState(() {
                    isLit = true;
                    postedImageSize = _imageContainerKey.currentContext.size;
                    _height = postedImageSize.height;
                  });

                  setState(() {
                    animationController.reset();
                    animationController.forward();
//                heartAnimationController.reset();
                    Future.delayed(Duration(milliseconds: 1000), () {
                      animationController.reset();
                    });
                  });
                },
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      widget.img,
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
                ))
          ],
        ),
      ),
    );
  }
}
