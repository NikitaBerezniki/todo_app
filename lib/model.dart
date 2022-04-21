import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  String? nameTask;
  void save() {}
}

class Provider extends InheritedNotifier<Model> {
  final Model model;

  Provider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static Provider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }
}
