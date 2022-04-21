import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/add_todo_page/add_todo_screen.dart';
import 'package:todo_app/home_page/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
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
        'todo_list/': (context) => const TodoListScreen(),
        'todo_list/add_todo': (context) => const AddTodoScreen(),
      },
      initialRoute: 'todo_list/',
    );
  }
}
