import 'package:flutter/material.dart';
import 'package:todo_app/model.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _model = Model();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление задачи'),
        centerTitle: true,
      ),
      body: Provider(model: _model, child: const _AddTodoForm()),
    );
  }
}

class _AddTodoForm extends StatelessWidget {
  const _AddTodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of(context)?.model;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onEditingComplete: () => model?.save(),
            onChanged: (value) => model?.save(),
            decoration: InputDecoration(hintText: 'Описание задачи'),
            autofocus: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                Provider.of(context)?.model.save();
                Navigator.pop(context);
              },
              child: Text('Добавить задачу'))
        ],
      ),
    );
  }
}
