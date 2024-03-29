
import 'package:flutter/material.dart';

class TapOutsideUnfocus extends StatelessWidget {
  final Widget child;

  TapOutsideUnfocus({@required this.child});

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: () {
          // Clear focus of our fields when tapped in this empty space
          FocusScope.of(context).unfocus();
        },
        child: this.child
      );
}
}