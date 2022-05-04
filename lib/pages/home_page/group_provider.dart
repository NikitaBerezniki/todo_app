import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/box_manager.dart';
import 'package:todo_app/pages/task_page/task_list_screen.dart';
import '../../main_navigation.dart';
import '../../entity/group.dart';

class GroupModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;

  ValueListenable<Object>? _listenableBox;

  List<Group> _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupModel() {
    _setup();
  }

  void showTaskList(BuildContext context, int index) async {
    final group = (await _box).getAt(index);
    if (group != null) {
      final configuration = TaskListScreenConfiguration(group.key, group.name);
      Navigator.of(context).pushNamed(MainNavigationOfRoutes.task_list,
          arguments: configuration);
    }
  }

  void showAddGroupScreen(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationOfRoutes.add_group);
  }

  Future<void> _readGroup() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> deleteGroup(int index) async {
    final box = await _box;
    final int groupKey = (await _box).keyAt(index);
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(index);
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openGroupBox();
    await _readGroup();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readGroup);
  }

  @override
  Future<void> dispose() async {
    _listenableBox?.removeListener(_readGroup);
    // await BoxManager.instance.closeBox(await _box);// Проблема
    super.dispose();
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
