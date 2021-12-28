import 'package:flutter/material.dart';


enum AppEnv { dev, prod }

class AppConfig extends InheritedWidget {
  final AppEnv? env;
  @override
  // ignore: overridden_fields
  final Widget child;
  final String? nameAppFirebase;
  
  AppConfig({Key? key,  @required this.env, required this.child, @required this.nameAppFirebase}) : super(key: key, child: Container());

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
  
}