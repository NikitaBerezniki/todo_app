import 'package:flutter/material.dart';
import 'package:todo_app/box_manager.dart';
import 'package:todo_app/entity/task.dart';

class AddTaskModel extends ChangeNotifier {
  int groupKey;
  String _taskText = '';
  bool get isValidTaskText => _taskText.trim().isNotEmpty;
  set taskText(String value) {
    final isTaskTextEmpty = _taskText.trim().isEmpty;
    _taskText = value;
    if (value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  }

  AddTaskModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;

    final task = Task(name: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box); // Работает!!!
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
