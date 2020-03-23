import 'package:flutter/material.dart';

class CircleUIConfig {
  final Color borderColor;
  final Color fillColor;
  final double borderWidth;
  final double circleSize;
  double extraSize;

  CircleUIConfig(
      {this.extraSize = 0,
      this.borderColor = Colors.tealAccent,
      this.borderWidth = 2,
      this.fillColor = Colors.tealAccent,
      this.circleSize = 41});
}

class Circle extends StatelessWidget {
  final bool filled;
  final CircleUIConfig circleUIConfig;

  Circle({Key key, this.filled = false, @required this.circleUIConfig})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(bottom: circleUIConfig.borderWidth),
      width: circleUIConfig.circleSize,
      height: circleUIConfig.circleSize,
      decoration: BoxDecoration(
          color: filled ? circleUIConfig.fillColor : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              
              color: circleUIConfig.borderColor,
              width: circleUIConfig.borderWidth)),
    );
  }
}
