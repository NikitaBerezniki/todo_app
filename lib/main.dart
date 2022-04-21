import 'package:flutter/material.dart';
import 'package:todo_app/add_todo_screen.dart';
import 'package:todo_app/todo_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      // home: TodoListScreen(),
      routes: {
        'todo_list/': (context) => TodoListScreen(),
        'todo_list/add_todo': (context) => AddTodoScreen(),
      },
      initialRoute: 'todo_list/',
    );
  }
}
