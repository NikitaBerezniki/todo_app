import 'package:hive/hive.dart';
part 'group_dataclass.g.dart';

@HiveType(typeId: 0)
class GroupDataClass extends HiveObject{
  @HiveField(0)
  String name;

  GroupDataClass({required this.name});

  @override
  String toString() => 'group: $name';
}
