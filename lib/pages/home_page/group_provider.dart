import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../entity/group_dataclass.dart';

class GroupModel extends ChangeNotifier {
  List<GroupDataClass> _groups = <GroupDataClass>[];

  GroupModel() {
    _setup();
  }

  List<GroupDataClass> get groups => _groups.toList();

  void showTasksList(BuildContext context, int index){

    Navigator.of(context).pushNamed('group_list/tasks_list/');
  }

  void showAddGroupScreen(BuildContext context){
    Navigator.of(context).pushNamed('group_list/add_group');
  }

  void _readTodoFromHive(Box<GroupDataClass> box) {
    _groups = box.values.toList();
    notifyListeners();
    // box.clear();
  }

  void deleteTodoFromHive(int index) async {
        if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupDataClassAdapter());
    }
    final Box<GroupDataClass> box = await Hive.openBox<GroupDataClass>('group');
    box.deleteAt(index);
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupDataClassAdapter());
    }
    final Box<GroupDataClass> box = await Hive.openBox<GroupDataClass>('group');

    _readTodoFromHive(box);
    box.listenable().addListener(() => _readTodoFromHive(box));
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
