import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/box_manager.dart';
import '../../main_navigation.dart';
import '../../entity/task.dart';
import 'task_list_screen.dart';

class TaskListModel extends ChangeNotifier {
  TaskListScreenConfiguration configuration;
  ValueListenable<Object>? _listenableBox;

  late final Future<Box<Task>> _box;
  List<Task> _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  TaskListModel({required this.configuration}) {
    _setup();
  }

  void showTaskList(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MainNavigationOfRoutes.add_task, arguments: configuration);
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTaskList();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTaskList);
  }

    @override
  Future<void> dispose() async {
    _listenableBox?.removeListener(_readTaskList);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }

  Future<void> doneToggle(int index) async {
    final task = (await _box).getAt(index);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  Future<void> deleteTask(int index) async {
    (await _box).deleteAt(index);
  }

  Future<void> _readTaskList() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }


}

class TaskProvider extends InheritedNotifier<TaskListModel> {
  final TaskListModel model;

  TaskProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static TaskProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProvider>();
  }
}
