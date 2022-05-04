import 'package:flutter/material.dart';
import 'package:todo_app/box_manager.dart';
import '../../entity/group.dart';

class AddGroupModel extends ChangeNotifier {
  String _nameGroup = '';
  String? errorText;
  set nameGroup(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _nameGroup = value;
  }

  void saveGroup(BuildContext context) async {
    final nameGroup = this._nameGroup.trim();
    if (nameGroup.isEmpty) {
      errorText = 'Введите название группы';
      notifyListeners();
      return;
    }

    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: nameGroup.trim());
    await box.add(group);
    // await BoxManager.instance.closeBox(box); // ПРОБЛЕМА
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
