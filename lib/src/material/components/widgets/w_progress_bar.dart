import 'package:flutter/material.dart';

class OwProgressBar extends StatelessWidget {
  final double height;
  final double radius;
  final Duration duration;
  final Color progressColor;
  final Color barColor;
  final Curve curve;
  final double maxWidth;

  final bool fill;
  final bool fullyEmpty;
  final bool resetWithoutAnimation;

  OwProgressBar({
    Key key,
    this.resetWithoutAnimation = false,
    this.fill = false,
    this.fullyEmpty = false,
    this.height = 10,
    this.radius = 10,
    this.duration = const Duration(milliseconds: 500),
    this.progressColor = Colors.blue, // ! Change
    this.barColor,
    this.curve = Curves.linear,
    this.maxWidth,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: barColor ?? progressColor.withOpacity(.4),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            curve: curve,
            duration: _defineDuration(),
            alignment: const Alignment(0, 0),
            width: _defineWidth(context),
            height: height,
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _defineWidth(BuildContext context) {
    if(fill) {
      return maxWidth ?? MediaQuery.of(context).size.width;
    } else {
      if(fullyEmpty) {
        return 0;
      } else {
        return height;
      }
    }
  }

  Duration _defineDuration() {
    if(resetWithoutAnimation) {
      return Duration.zero;
    } else {
      return duration;
    }
  }
}
