import 'package:flutter/material.dart';

class IndexPageProvide with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
