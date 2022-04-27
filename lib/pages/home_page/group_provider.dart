import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/box_manager.dart';
import 'package:todo_app/pages/task_page/task_screen.dart';
import '../../main_navigation.dart';
import '../../entity/group.dart';

class GroupModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;
  List<Group> _groups = <Group>[];

  GroupModel() {
    _setup();
  }

  List<Group> get groups => _groups.toList();

  void showTaskList(BuildContext context, int index) async {
    final group = (await _box).getAt(index);
    if (group != null) {
      final configuration = TaskScreenConfiguration(group.key, group.name);
      Navigator.of(context)
          .pushNamed(MainNavigationOfRoutes.task_list, arguments: configuration);
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
    // await box.getAt(index)?.tasks?.deleteAllFromHive();
    await box.deleteAt(index);
  }

  void _setup() async {
    // await BoxManager.instance.openTaskBox();
    _box = BoxManager.instance.openGroupBox();
    await _readGroup();
    (await _box).listenable().addListener(_readGroup);
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
