import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/pages/task_page/task_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)?.settings.arguments as int;
      _model = TaskModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      model: _model!,
      child: _TaskListWidget(),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskProvider.of(context)?.model;
    // final group = model?.tasks[index];
    final titleGroup = model?.group?.name ?? 'Задача';
    final tasks = model?.tasks;

    return Scaffold(
      appBar: AppBar(title: Text(titleGroup), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
            itemBuilder: (context, index) {

              return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          TaskProvider.of(context)!.model.deleteTask(index);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading:
                        Text(tasks?.elementAt(index).name ?? '!!!!!!!!!!!!'),
                  ));
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: tasks?.length ?? 0),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => model?.showTaskList(context),
          child: Icon(Icons.add)),
    );
  }
}
