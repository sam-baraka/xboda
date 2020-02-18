import 'dart:async';

import 'package:flutter/cupertino.dart';

class ThemeManager {
  StreamController<CupertinoThemeData> _themeController;

  List<CupertinoThemeData> _availableThemes = [
    ///Dark theme
    CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.activeOrange),
    //Light theme
    CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.activeOrange),
  ];

  Stream<CupertinoThemeData> get theme => _themeController.stream;

  int _currentTheme = 0;

  Future changeTheme() async {
    _currentTheme++;
    if (_currentTheme >= _availableThemes.length) {
      _currentTheme = 0;
    }

    // Get the theme to apply
    var themeToApply = _availableThemes[_currentTheme];

    _themeController.add(themeToApply);
  }
}
