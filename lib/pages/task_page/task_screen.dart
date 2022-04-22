import 'package:flutter/material.dart';
import 'package:todo_app/pages/task_page/task_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final model = TaskModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Задачи'), centerTitle: true),
      body: TaskProvider(
        model: model,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(leading: Text('123'));
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: 2),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('group_list/tasks_list/add_task');
          },
          child: Icon(Icons.add)),
    );
  }
}
