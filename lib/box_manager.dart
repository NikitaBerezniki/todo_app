import 'package:hive/hive.dart';

import 'entity/group.dart';
import 'entity/task.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  final Map<String, int> _boxCounter = <String, int>{};
  // шаблон Singleton
  // чтобы никто не смог создать экземпляр класса.
  // это приватный конструктор
  BoxManager._();

  String makeTaskBoxName(int groupKey) => 'task_box_$groupKey';

  Future<Box<Group>> openGroupBox() async {
    print('Открываем бокс с группой');
    return _openBox('group', 0, GroupAdapter());
  }

  Future<Box<Task>> openTaskBox(int groupKey) async {
    print('Открываем бокс task_box_$groupKey');
    return _openBox(makeTaskBoxName(groupKey), 1, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (await box.isOpen) {
      print('Бокс ${box.name} закрываем ');
      await box.compact();
      await box.close();
    }
  }

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
