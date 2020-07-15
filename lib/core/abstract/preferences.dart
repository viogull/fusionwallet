import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'preferences.g.dart';

@HiveType(typeId: 2)
class Preferences extends HiveObject {
  @HiveField(0)
  bool biometricEnabled = false;
  @HiveField(1)
  bool darkThemeEnabled = true;
  @HiveField(2)
  String locale = 'ru';
  @HiveField(3)
  String name = "";

  Preferences();
}
