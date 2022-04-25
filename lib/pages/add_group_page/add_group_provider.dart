import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../entity/group.dart';


class AddGroupModel extends ChangeNotifier {
  String nameGroup = '';
  void save(BuildContext context) async {
    if (nameGroup == '') return;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final Box box = await Hive.openBox<Group>('group');
    final group = Group(name: nameGroup);
    await box.add(group); 
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
