import 'package:hive/hive.dart';
part 'todo_dataclass.g.dart';

@HiveType(typeId: 0)
class TodoDataClass extends HiveObject{
  @HiveField(0)
  String name;

  TodoDataClass({required this.name});

  @override
  String toString() => name;
}
