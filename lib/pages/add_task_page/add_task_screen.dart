import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_task_page/add_task_provider.dart';
import 'package:todo_app/pages/task_page/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late AddTaskModel _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (_model == null) {
    final groupKey = ModalRoute.of(context)?.settings.arguments as int;
    _model = AddTaskModel(groupKey: groupKey);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AddTaskProvider(model: _model, child: AddTaskWidget());
  }
}

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AddTaskProvider.of(context)?.model;
    return Scaffold(
      appBar: AppBar(title: Text('Добавление задачи'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                  minLines: null,
                  maxLines: null,
                  expands: true,
                  onChanged: (value) => model?.taskName = value,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Описание задачи')),
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => model?.saveTask(context),
                child: Text('Добавить задачу'))
          ],
        ),
      ),
    );
  }
}
