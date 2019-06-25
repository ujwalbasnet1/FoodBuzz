import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> heartAnimation;
  Animation curveHeartAnimation;
  AnimationController heartAnimationController;

  @override
  void initState() {
    super.initState();
    heartAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    curveHeartAnimation = CurvedAnimation(
        parent: heartAnimationController, curve: Curves.easeOutBack);

    heartAnimation =
        Tween<double>(begin: 0, end: 1).animate(curveHeartAnimation)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          InkWell(
              onDoubleTap: () {
                setState(() {
//                _visible = !_visible;
                  heartAnimationController.reset();
                  heartAnimationController.forward();
//                heartAnimationController.reset();
                  Future.delayed(Duration(milliseconds: 1000), () {
                    heartAnimationController.reset();
                  });
                });
              },
              child: Container(height: 300, color: Colors.redAccent)),
          Center(
            child: Icon(
              Icons.whatshot,
              size: 96 * heartAnimation.value,
              color: Colors.white.withOpacity(0.85),
            ),
          )
        ],
      ),
    );
  }
}
