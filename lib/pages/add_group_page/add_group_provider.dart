import 'package:flutter/material.dart';
import 'package:todo_app/box_manager.dart';
import '../../entity/group.dart';

class AddGroupModel extends ChangeNotifier {
  String nameGroup = '';

  void saveGroup(BuildContext context) async {
    if (nameGroup == '') return;
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: nameGroup);
    await box.add(group);
    // await BoxManager.instance.closeBox(box);
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
