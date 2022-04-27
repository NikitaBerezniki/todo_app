import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/box_manager.dart';
import '../../main_navigation.dart';
// import '../../entity/group.dart';
import '../../entity/task.dart';
import 'task_screen.dart';


class TaskListModel extends ChangeNotifier {
  // final int groupKey;
  TaskScreenConfiguration configuration;
  late final Future<Box<Task>> _box;
  List<Task> _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  TaskListModel({required this.configuration}) {
    _setup();
  }

  void showTaskList(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MainNavigationOfRoutes.add_task, arguments: configuration.groupKey);
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTaskList();
    (await _box).listenable().addListener(_readTaskList);
  }

  Future<void> doneToggle(int index) async {
    final task = (await _box).getAt(index);
    task?.isDone = !task.isDone;
  }

  Future<void> deleteTask(int index) async {
    final box = await _box;
    (await _box).deleteAt(index);
  }

  Future<void> _readTaskList() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  // void doneToggle(){
  // final task = group?.tasks?[index];
  // final currentState = task?.isDone ?? false;
  // task?.isDone = !currentState;
  // await task?.save();
  // notifyListeners();
  // }

  // void deleteTask(int index){    // if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TaskAdapter());
  // await Hive.openBox<Task>('task');
  // await _group?.tasks?.deleteFromHive(index);
  // await group?.save();}

  // void _listenTaskList() async {
  //   final box = await _group_box;
  //   _group = box.get(groupKey);
  //   notifyListeners();
  //   box.listenable(keys: [groupKey]).addListener(_readTaskList);
  //   _readTaskList();
  // }

  // void _setup1() {
  //   if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(GroupAdapter());
  //   _group_box = Hive.openBox<Group>('group');
  //   _listenGroup();
  //   // Hive.openBox<Group>('task');
  // }
}

class TaskProvider extends InheritedNotifier<TaskListModel> {
  final TaskListModel model;

  TaskProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static TaskProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProvider>();
  }
}
