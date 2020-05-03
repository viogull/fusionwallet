import 'dart:io';

import 'package:flutter/material.dart';

import '../../localizations.dart';
import '../../utils/routes.dart';

class Sheets {
  //App Ninty Height Sheet
  static Future<T> showFusionSheet<T>(
      {@required BuildContext context,
      @required Widget widget,
      Color color,
      double radius = 30.0,
      Color bgColor,
      int animationDurationMs = 250,
      bool removeUntilHome = false,
      bool closeOnTap = false,
      Function onDisposed}) {
    assert(context != null);
    assert(widget != null);
    assert(radius != null && radius > 0.0);
    if (color == null) {
      color = Theme.of(context).colorScheme.background;
    }
    if (bgColor == null) {
      bgColor = Theme.of(context).colorScheme.background;
    }
    var route = _FusionModalRoute<T>(
        builder: (BuildContext context) {
          return widget;
        },
        color: color,
        radius: radius,
        barrierLabel: AppLocalizations.of(context).buttonClose(),
        bgColor: bgColor,
        animationDurationMs: animationDurationMs,
        closeOnTap: closeOnTap,
        onDisposed: onDisposed);
    if (removeUntilHome) {
      return Navigator.pushAndRemoveUntil<T>(
          context, route, RouteUtils.withNameLike('/home'));
    }
    return Navigator.push<T>(context, route);
  }

  static Future<T> showFusionBottomSheet<T>(
      {@required BuildContext context,
      @required Widget widget,
      Color color,
      double radius = 64.0,
      Color bgColor,
      int animationDurationMs = 450}) {
    assert(context != null);
    assert(widget != null);
    assert(radius != null && radius > 0.0);
    if (color == null) {
      color = Theme.of(context).colorScheme.primary;
    }
    if (bgColor == null) {
      bgColor = Theme.of(context).bottomSheetTheme.backgroundColor;
    }
    return Navigator.push<T>(
        context,
        FusionModalRoute<T>(
            builder: (BuildContext context) {
              return widget;
            },
            color: color,
            radius: radius,
            barrierLabel: AppLocalizations.of(context).buttonClose(),
            bgColor: bgColor,
            animationDurationMs: animationDurationMs));
  }
}

class _FusionSheetLayout extends SingleChildLayoutDelegate {
  _FusionSheetLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    if (constraints.maxHeight < 667)
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.95);
    if ((constraints.maxHeight / constraints.maxWidth > 2.1 &&
            Platform.isAndroid) ||
        constraints.maxHeight > 812)
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.8);
    else
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.9);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_FusionSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _FusionModalRoute<T> extends PopupRoute<T> {
  _FusionModalRoute(
      {this.builder,
      this.barrierLabel,
      this.color,
      this.radius,
      RouteSettings settings,
      this.bgColor,
      this.animationDurationMs,
      this.closeOnTap,
      this.onDisposed})
      : super(settings: settings);

  final WidgetBuilder builder;
  final double radius;
  final Color color;
  final Color bgColor;
  final int animationDurationMs;
  final bool closeOnTap;
  final Function onDisposed;

  @override
  Color get barrierColor => bgColor;

  @override
  bool get barrierDismissible => true;

  @override
  String barrierLabel;

  @override
  void didComplete(T result) {
    if (onDisposed != null) {
      onDisposed();
    }
    super.didComplete(result);
  }

  AnimationController _animationController;
  CurvedAnimation appSheetAnimation;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    _animationController.duration = Duration(milliseconds: animationDurationMs);
    this.appSheetAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.linear)
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          appSheetAnimation.curve = Curves.linear;
        }
      });
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GestureDetector(
        onTap: () {
          if (closeOnTap) {
            // Close when tapped anywhere
            Navigator.of(context).pop();
          }
        },
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: AnimatedBuilder(
            animation: appSheetAnimation,
            builder: (context, child) => CustomSingleChildLayout(
              delegate: _FusionSheetLayout(appSheetAnimation.value),
              child: BottomSheet(
                animationController: _animationController,
                onClosing: () => Navigator.pop(context),
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    color: this.color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(this.radius),
                      topRight: Radius.circular(this.radius),
                    ),
                  ),
                  child: Builder(builder: this.builder),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: animationDurationMs);
}
//App Height Nine Sheet End

class _AppHeightEightSheetLayout extends SingleChildLayoutDelegate {
  _AppHeightEightSheetLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    if (constraints.maxHeight < 667)
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.9);
    if (constraints.maxHeight / constraints.maxWidth > 2.1)
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.7);
    else
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.8);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_AppHeightEightSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class FusionModalRoute<T> extends PopupRoute<T> {
  FusionModalRoute(
      {this.builder,
      this.barrierLabel,
      this.color,
      this.radius,
      RouteSettings settings,
      this.bgColor,
      this.animationDurationMs})
      : super(settings: settings);

  final WidgetBuilder builder;
  final double radius;
  final Color color;
  final Color bgColor;
  final int animationDurationMs;

  @override
  Color get barrierColor => bgColor;

  @override
  bool get barrierDismissible => true;

  @override
  String barrierLabel;

  AnimationController _animationController;
  CurvedAnimation appSheetAnimation;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    _animationController.duration = Duration(milliseconds: animationDurationMs);
    this.appSheetAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.linear)
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          appSheetAnimation.curve = Curves.linear;
        }
      });
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: AnimatedBuilder(
          animation: appSheetAnimation,
          builder: (context, child) => CustomSingleChildLayout(
            delegate: _AppHeightEightSheetLayout(appSheetAnimation.value),
            child: BottomSheet(
              animationController: _animationController,
              onClosing: () => Navigator.pop(context),
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(this.radius),
                    topRight: Radius.circular(this.radius),
                  ),
                ),
                child: Builder(builder: this.builder),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: animationDurationMs);
}
//App HeightEight Sheet End
