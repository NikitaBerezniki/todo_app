import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../entity/todo_dataclass.dart';

class TodoModel extends ChangeNotifier {
  List<TodoDataClass> _todoList = <TodoDataClass>[];

  TodoModel() {
    _setup();
  }

  List<TodoDataClass> get todoList => _todoList.toList();

  void _readTodoFromHive(Box<TodoDataClass> box) {
    _todoList = box.values.toList();
    notifyListeners();
    // box.clear();
  }

  void deleteTodoFromHive(int index) async {
    final Box<TodoDataClass> box = await Hive.openBox<TodoDataClass>('todo');
    box.deleteAt(index);
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(TodoDataClassAdapter());
    final Box<TodoDataClass> box = await Hive.openBox<TodoDataClass>('todo');

    _readTodoFromHive(box);
    box.listenable().addListener(() => _readTodoFromHive(box));
  }
}

class TodoProvider extends InheritedNotifier<TodoModel> {
  final TodoModel model;

  TodoProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static TodoProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoProvider>();
  }
}
