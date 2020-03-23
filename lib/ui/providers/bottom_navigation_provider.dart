import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  Future<void> set(int index) async {
    _currentIndex = index;
    logger.d('Notifing pages about navigation to index: $index');
    notifyListeners();
  }
}
