import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BlocLoadingIndicator extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => BlocLoadingIndicator(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  BlocLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          elevation: 1,
          color: Colors.transparent,
          child: Container(
            width: 32,
            height: 32,
            padding: EdgeInsets.all(16.0),
            child: PlatformCircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
