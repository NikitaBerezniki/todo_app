import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../constants.dart';
import '../../entity/group.dart';
import '../../entity/task.dart';

class TaskModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _group_box;
  Group? _group;
  Group? get group => _group;

  TaskModel({required this.groupKey}) {
    _setup();
  }
  List<Task> _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  void showTaskList(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.add_task, arguments: groupKey);
  }

  void doneToggle(int index) async {
    final task = group?.tasks?[index];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _readTaskList() async {
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>('task');
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void deleteTask(int index) async {
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>('task');
    await _group?.tasks?.deleteFromHive(index);
    await group?.save();
  }

  void _listenGroup() async {
    final box = await _group_box;
    _group = box.get(groupKey);
    notifyListeners();
    box.listenable(keys: [groupKey]).addListener(_readTaskList);
    _readTaskList();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(GroupAdapter());
    _group_box = Hive.openBox<Group>('group');
    _listenGroup();
    // Hive.openBox<Group>('task');
  }
}

class TaskProvider extends InheritedNotifier<TaskModel> {
  final TaskModel model;

  TaskProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static TaskProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProvider>();
  }
}
