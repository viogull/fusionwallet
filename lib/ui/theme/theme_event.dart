import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  final List _props;

  List<Object> get props => _props;

  ThemeEvent(this._props);
}

class ThemeChanged extends ThemeEvent {
  final FusionThemes theme;

  ThemeChanged({@required this.theme}) : super([theme]);

  @override
  List<Object> get props => const [];
}
