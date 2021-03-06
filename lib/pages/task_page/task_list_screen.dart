import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/pages/task_page/task__list_provider.dart';

class TaskListScreenConfiguration {
  final int groupKey;
  final String title;

  TaskListScreenConfiguration(this.groupKey, this.title);
}

class TaskListScreen extends StatefulWidget {
  final TaskListScreenConfiguration configuration;
  const TaskListScreen({Key? key, required this.configuration}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late final TaskListModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskListModel(configuration: widget.configuration);
  }

  @override
  Future<void>  dispose() async {
    // убрал await!
    _model.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_model == null) {
  //     final groupKey = ModalRoute.of(context)?.settings.arguments as int;
  //     _model = TaskModel(groupKey: groupKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      model: _model,
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
    final model = TaskProvider.of(context)!.model;
    final titleGroup = model.configuration.title;
    final tasks = model.tasks;

    return Scaffold(
      appBar: AppBar(title: Text(titleGroup), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              final task = TaskProvider.of(context)!.model.tasks[index];
              final icon = task.isDone ? Icon(Icons.done) : null;
              final style = task.isDone
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : null;
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
                    trailing: icon,
                    onTap: () => model.doneToggle(index),
                    leading: Text(
                      task.name,
                      style: style,
                    ),
                  ));
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: tasks.length),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => model.showTaskList(context), child: Icon(Icons.add)),
    );
  }
}
