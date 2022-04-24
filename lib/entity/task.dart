import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String name;
  // @HiveField(1)
  // HiveList<Group>? group;
  @HiveField(2)
  bool isDone;

  Task({required this.name, required this.isDone});
  @override
  String toString() {
    return 'task: $name ';
  }
}
