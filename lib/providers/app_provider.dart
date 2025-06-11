import 'dart:async';

import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String searchQuery = "";
  Timer? _debounce;

  void setSearchQuery(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      searchQuery = query;
      notifyListeners();
    });
  }
}
