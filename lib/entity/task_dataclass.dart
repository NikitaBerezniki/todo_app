import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/entity/group_dataclass.dart';
part 'task_dataclass.g.dart';

@HiveType(typeId: 1)
class TaskDataClass extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  HiveList<GroupDataClass>? group;

  TaskDataClass({required this.name, this.group});
  @override
  String toString() {
    return 'task: $name $group';
  }
}
