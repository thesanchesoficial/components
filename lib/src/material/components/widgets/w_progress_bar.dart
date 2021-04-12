import 'package:flutter/material.dart';

class OwProgressBar extends StatelessWidget {
  final double height;
  final double radius;
  final Color progressBarColor;
  final Color barColor;
  final Duration duration;
  final Curve curve;
  final bool animated;
  final int totalSteps;
  final int filledSteps;
  final double fillPercent;

  OwProgressBar({
    Key key,
    this.animated = true,
    this.height = 10,
    this.radius = 10,
    this.duration = const Duration(seconds: 1),
    this.progressBarColor = Colors.green, // ! Change
    this.barColor = Colors.grey,
    this.curve = Curves.linear,
    this.totalSteps = 10,
    this.filledSteps = 1,
    this.fillPercent,
  })  : assert(fillPercent == null || (fillPercent != null && fillPercent <= 1)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: key,
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: barColor,
        ),
        child: LayoutBuilder(
          builder: (context, constriants) {
            return Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                curve: curve,
                duration: _defineDuration(),
                width: _defineWidth(constriants.maxWidth),
                height: height,
                decoration: BoxDecoration(
                  color: progressBarColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius),
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }

  double _defineWidth(double width) {
    if(fillPercent != null) {
      return fillPercent * width;
    } else {
      return (filledSteps / totalSteps) * width;
    }
  }

  Duration _defineDuration() {
    if(animated) {
      return duration;
    } else {
      return Duration.zero;
    }
  }
}
