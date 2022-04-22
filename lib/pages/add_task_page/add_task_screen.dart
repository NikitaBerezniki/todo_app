import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавление задачи'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Описание задачи')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('Добавить задачу'))
          ],
        ),
      ),
    );
  }
}
