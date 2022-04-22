import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/add_group_page/add_group_screen.dart';
import 'package:todo_app/pages/add_task_page/add_task_screen.dart';
import 'package:todo_app/pages/home_page/group_screen.dart';
import 'package:todo_app/pages/task_page/task_screen.dart';

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
      routes: {
        'group_list/': (context) => const GroupListScreen(),
        'group_list/add_group': (context) => const AddGroupScreen(),
        'group_list/tasks_list/': (context)=>const TaskScreen(),
        'group_list/tasks_list/add_task': (context)=>const AddTaskScreen(),
      },
      initialRoute: 'group_list/',
    );
  }
}
