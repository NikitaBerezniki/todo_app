import 'package:flutter/material.dart';
import 'package:todo_app/add_todo_page/add_todo_provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _model = AddTodoModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление задачи'),
        centerTitle: true,
      ),
      body: AddTodoProvider(model: _model, child: const _AddTodoForm()),
    );
  }
}

class _AddTodoForm extends StatelessWidget {
  const _AddTodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AddTodoProvider.of(context)?.model;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
              // model?.save(context);
            },
            onChanged: (value) => model?.nameTask = value,
            decoration: const InputDecoration(hintText: 'Описание задачи'),
            autofocus: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                model?.save(context);
              },
              child: const Text('Добавить задачу'))
        ],
      ),
    );
  }
}
