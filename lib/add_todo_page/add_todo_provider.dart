import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../entity/todo_dataclass.dart';

class AddTodoModel extends ChangeNotifier {
  String nameTask = '';
  void save(BuildContext context) async {
    if (nameTask == '') return;
    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(TodoDataClassAdapter());
    final Box box = await Hive.openBox<TodoDataClass>('todo');
    final task = TodoDataClass(name: nameTask);
    await box.add(task); // unawaited(box.add(task));
    Navigator.of(context).pop();
  }
}

class addTodoProvider extends InheritedNotifier<AddTodoModel> {
  final AddTodoModel model;

  addTodoProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static addTodoProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<addTodoProvider>();
  }
}