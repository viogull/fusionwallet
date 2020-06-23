import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AppDrawerAlignment {
  start,
  end,
}

// http://material.google.com/layout/structure.html#structure-side-nav

// Mobile:
// Width = Screen width − 56 dp
// Maximum width: 320dp
// Maximum width applies only when using a left nav. When using a right nav,
// the panel can cover the full width of the screen.

// Desktop/Tablet:
// Maximum width for a left nav is 400dp.
// The right nav can vary depending on content.

const double _kWidth = 304.0;
const double _kEdgeDragWidth = 200.0;
const double _kMinFlingVelocity = 365.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class FusionDrawer extends StatelessWidget {
  /// Creates a material design drawer.
  ///
  /// Typically used in the [Scaffold.drawer] property.
  const FusionDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
  }) : super(key: key);

  /// The z-coordinate at which to place this drawer. This controls the size of
  /// the shadow below the drawer.
  ///
  /// Defaults to 16, the appropriate elevation for drawers.
  final double elevation;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [SliverList].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// [MaterialLocalizations.drawerLabel].

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;

        break;
      case TargetPlatform.macOS:
        // TODO: Handle this case.
        break;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(width: _kWidth),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}

/// Signature for the callback that's called when a [AppDrawerController] is
/// opened or closed.
typedef AppDrawerCallback = void Function(bool isOpened);

/// Provides interactive behavior for [Drawer] widgets.
///
/// Rarely used directly. Drawer controllers are typically created automatically
/// by [Scaffold] widgets.
///
/// The draw controller provides the ability to open and close a drawer, either
/// via an animation or via user interaction. When closed, the drawer collapses
/// to a translucent gesture detector that can be used to listen for edge
/// swipes.
///
/// See also:
///
///  * [Drawer], a container with the default width of a drawer.
///  * [Scaffold.drawer], the [Scaffold] slot for showing a drawer.
class AppDrawerController extends StatefulWidget {
  /// Creates a controller for a [Drawer].
  ///
  /// Rarely used directly.
  ///
  /// The [child] argument must not be null and is typically a [Drawer].
  const AppDrawerController({
    GlobalKey key,
    @required this.child,
    @required this.alignment,
    this.drawerCallback,
  })  : assert(child != null),
        assert(alignment != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Drawer].
  final Widget child;

  /// The alignment of the [Drawer].
  ///
  /// This controls the direction in which the user should swipe to open and
  /// close the drawer.
  final AppDrawerAlignment alignment;

  /// Optional callback that is called when a [Drawer] is opened or closed.
  final AppDrawerCallback drawerCallback;

  @override
  AppDrawerControllerState createState() => AppDrawerControllerState();
}

/// State for a [AppDrawerController].
///
/// Typically used by a [Scaffold] to [open] and [close] the drawer.
class AppDrawerControllerState extends State<AppDrawerController>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: _kBaseSettleDuration, vsync: this)
          ..addListener(_animationChanged)
          ..addStatusListener(_animationStatusChanged);
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  void _animationChanged() {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });
  }

  LocalHistoryEntry _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic> route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
        _ensureHistoryEntry();
        break;
      case AnimationStatus.reverse:
        _historyEntry?.remove();
        _historyEntry = null;
        break;
      case AnimationStatus.dismissed:
        break;
      case AnimationStatus.completed:
        break;
    }
  }

  void _handleHistoryEntryRemoved() {
    _historyEntry = null;
    close();
  }

  AnimationController _controller;

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
    _ensureHistoryEntry();
  }

  void _handleDragCancel() {
    if (_controller.isDismissed || _controller.isAnimating) return;
    if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  final GlobalKey _drawerKey = GlobalKey();

  double get _width {
    final RenderBox box = _drawerKey.currentContext?.findRenderObject();
    if (box != null) return box.size.width;
    return _kWidth; // drawer not being shown currently
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta / _width;
    switch (widget.alignment) {
      case AppDrawerAlignment.start:
        break;
      case AppDrawerAlignment.end:
        delta = -delta;
        break;
    }
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }

    final bool opened = _controller.value > 0.5 ? true : false;
    if (opened != _previouslyOpened && widget.drawerCallback != null)
      widget.drawerCallback(opened);
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;
      switch (widget.alignment) {
        case AppDrawerAlignment.start:
          break;
        case AppDrawerAlignment.end:
          visualVelocity = -visualVelocity;
          break;
      }
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          break;
      }
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  /// Starts an animation to open the drawer.
  ///
  /// Typically called by [ScaffoldState.openDrawer].
  void open() {
    _controller.fling(velocity: 1.0);
    if (widget.drawerCallback != null) widget.drawerCallback(true);
  }

  /// Starts an animation to close the drawer.
  void close() {
    _controller.fling(velocity: -1.0);
    if (widget.drawerCallback != null) widget.drawerCallback(false);
  }

  final ColorTween _color =
      ColorTween(begin: Colors.transparent, end: Colors.black54);
  final GlobalKey _gestureDetectorKey = GlobalKey();

  AlignmentDirectional get _drawerOuterAlignment {
    assert(widget.alignment != null);
    switch (widget.alignment) {
      case AppDrawerAlignment.start:
        return AlignmentDirectional.centerStart;
      case AppDrawerAlignment.end:
        return AlignmentDirectional.centerEnd;
    }
    return null;
  }

  AlignmentDirectional get _drawerInnerAlignment {
    assert(widget.alignment != null);
    switch (widget.alignment) {
      case AppDrawerAlignment.start:
        return AlignmentDirectional.centerEnd;
      case AppDrawerAlignment.end:
        return AlignmentDirectional.centerStart;
    }
    return null;
  }

  Widget _buildDrawer(BuildContext context) {
    final bool drawerIsStart = widget.alignment == AppDrawerAlignment.start;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    double dragAreaWidth = drawerIsStart ? padding.left : padding.right;

    if (Directionality.of(context) == TextDirection.rtl)
      dragAreaWidth = drawerIsStart ? padding.right : padding.left;

    dragAreaWidth = max(dragAreaWidth, _kEdgeDragWidth);
    if (_controller.status == AnimationStatus.dismissed) {
      return Align(
        alignment: _drawerOuterAlignment,
        child: GestureDetector(
          key: _gestureDetectorKey,
          onHorizontalDragUpdate: _move,
          onHorizontalDragEnd: _settle,
          behavior: HitTestBehavior.translucent,
          excludeFromSemantics: true,
          child: Container(width: dragAreaWidth),
        ),
      );
    } else {
      return GestureDetector(
        key: _gestureDetectorKey,
        onHorizontalDragDown: _handleDragDown,
        onHorizontalDragUpdate: _move,
        onHorizontalDragEnd: _settle,
        onHorizontalDragCancel: _handleDragCancel,
        excludeFromSemantics: true,
        child: RepaintBoundary(
          child: Stack(
            children: <Widget>[
              BlockSemantics(
                child: GestureDetector(
                  // On Android, the back button is used to dismiss a modal.
                  excludeFromSemantics:
                      defaultTargetPlatform == TargetPlatform.android,
                  onTap: close,
                  child: Semantics(
                    label: MaterialLocalizations.of(context)
                        ?.modalBarrierDismissLabel,
                    child: Container(
                      color: _color.evaluate(_controller),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: _drawerOuterAlignment,
                child: Align(
                  alignment: _drawerInnerAlignment,
                  widthFactor: _controller.value,
                  child: RepaintBoundary(
                    child: FocusScope(
                      key: _drawerKey,
                      node: _focusScopeNode,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: _buildDrawer(context),
    );
  }
}
