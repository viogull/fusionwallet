import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScaffoldStackBgWidget extends StatelessWidget {
  final Widget child;

  ScaffoldStackBgWidget([this.child]);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SvgPicture.asset(
            "assets/images/backgrounds/bg_primary.svg",
            fit: BoxFit.fill,
          ),
        ),
        child
      ],
    );
  }
}
