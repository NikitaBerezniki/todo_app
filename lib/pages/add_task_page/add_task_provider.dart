import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/entity/group.dart';
import 'package:todo_app/entity/task.dart';

class AddTaskModel extends ChangeNotifier {
  int groupKey;
  String taskName = '';
  AddTaskModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (taskName == '') return;

    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(GroupAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TaskAdapter());
    final Box<Task> taskBox = await Hive.openBox<Task>('task');
    final task = Task(name: taskName, isDone: false);
    await taskBox.add(task);

    final Box<Group> groupBox = await Hive.openBox<Group>('group');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    notifyListeners();
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