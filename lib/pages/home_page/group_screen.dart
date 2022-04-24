import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../entity/group.dart';
import 'group_provider.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  final model = GroupModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Список групп', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: GroupProvider(model: model, child: const _TodoListWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.showAddGroupScreen(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _TodoListWidget extends StatelessWidget {
  const _TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoCount = GroupProvider.of(context)?.model.groups.length ?? 0;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey.withOpacity(0.1), thickness: 1);
          },
          itemCount: todoCount,
          itemBuilder: (BuildContext context, int index) {
            final Group itemTodo =
                GroupProvider.of(context)!.model.groups[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      GroupProvider.of(context)!
                          .model
                          .deleteGroup(index);
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                  onTap: () => GroupProvider.of(context)!
                          .model.showTaskList(context, index),
                  leading: Text(itemTodo.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                    splashRadius: 20,
                  )),
            );
          }),
    );
  }
}
