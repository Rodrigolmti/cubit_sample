import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    @required this.appName,
    @required Widget child,
    @required this.appAccentColor,
  }) : super(child: child);

  final String appName;
  final Color appAccentColor;

  static AppConfig of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConfig>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
