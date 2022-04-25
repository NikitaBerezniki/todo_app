import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../main_navigation.dart';
import '../../entity/group.dart';
import '../../entity/task.dart';

class GroupModel extends ChangeNotifier {
  List<Group> _groups = <Group>[];

  GroupModel() {
    _setup();
  }

  List<Group> get groups => _groups.toList();

  void showTaskList(BuildContext context, int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final Box<Group> box = await Hive.openBox<Group>('group');
    final int groupKey = box.keyAt(index);

    Navigator.of(context).pushNamed(MainNavigationOfRoutes.task_list, arguments: groupKey);
  }

  void showAddGroupScreen(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationOfRoutes.add_group);
  }

  void _readGroup(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void deleteGroup(int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final Box<Group> box = await Hive.openBox<Group>('group');

    await box.getAt(index)?.tasks?.deleteAllFromHive();
    await box.deleteAt(index);
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
            if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }

    final Box<Group> box = await Hive.openBox<Group>('group');
    _readGroup(box);
    box.listenable().addListener(() => _readGroup(box));
  }
}

class GroupProvider extends InheritedNotifier<GroupModel> {
  final GroupModel model;

  const GroupProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static GroupProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupProvider>();
  }
}
