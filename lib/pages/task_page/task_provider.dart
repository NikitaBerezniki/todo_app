import 'package:flutter/cupertino.dart';
import '../../entity/task_dataclass.dart';

class TaskModel extends ChangeNotifier {
  List<TaskDataClass> _tasks = <TaskDataClass>[];

  List<TaskDataClass> get tasks => _tasks;
  
}

class TaskProvider extends InheritedNotifier<TaskModel> {
  final TaskModel model;

  TaskProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static TaskProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProvider>();
  }
}
