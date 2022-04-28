import 'package:flutter/material.dart';
import 'package:todo_app/box_manager.dart';
import 'package:todo_app/entity/task.dart';

class AddTaskModel extends ChangeNotifier {
  int groupKey;
  String taskText = '';
  AddTaskModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (taskText == '') return;
    final task = Task(name: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();

    // if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(GroupAdapter());
    // if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TaskAdapter());
    // final Box<Task> taskBox = await Hive.openBox<Task>('task');
    // final task = Task(name: taskText, isDone: false);
    // await taskBox.add(task);

    // final Box<Group> groupBox = await Hive.openBox<Group>('group');
    // final group = groupBox.get(groupKey);
    // group?.addTask(taskBox, task);
    // notifyListeners();
    // Navigator.of(context).pop();
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
