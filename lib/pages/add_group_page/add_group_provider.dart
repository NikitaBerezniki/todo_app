import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../entity/group_dataclass.dart';


class AddGroupModel extends ChangeNotifier {
  String nameGroup = '';
  void save(BuildContext context) async {
    if (nameGroup == '') return;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupDataClassAdapter());
    }
    final Box box = await Hive.openBox<GroupDataClass>('group');
    final group = GroupDataClass(name: nameGroup);
    await box.add(group); // unawaited(box.add(task));
    Navigator.of(context).pop();
  }
}

class AddGroupProvider extends InheritedNotifier<AddGroupModel> {
  final AddGroupModel model;

  const AddGroupProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static AddGroupProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AddGroupProvider>();
  }
}
