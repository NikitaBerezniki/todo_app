import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/entity/group_dataclass.dart';
import 'package:todo_app/entity/task_dataclass.dart';

class AddTaskModel extends ChangeNotifier {
  String taskName = '';
  void save(BuildContext context) async {
    if (taskName == '') return;
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(TaskDataClassAdapter());
    final Box<TaskDataClass> box = await Hive.openBox<TaskDataClass>('tasks');
    // :TODO ?: 123
    // await box.add(TaskDataClass(name: taskName, group: GroupDataClass(name: )));
    Navigator.of(context).pop();
  }
}

class AddTaskProvider extends InheritedNotifier<AddTaskModel> {
  final AddTaskModel model;

  AddTaskProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static AddTaskProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AddTaskProvider>();
  }
}
