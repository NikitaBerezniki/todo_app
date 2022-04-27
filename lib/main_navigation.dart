import 'package:flutter/material.dart';
import 'pages/add_group_page/add_group_screen.dart';
import 'pages/add_task_page/add_task_screen.dart';
import 'pages/home_page/group_screen.dart';
import 'pages/task_page/task_screen.dart';

abstract class MainNavigationOfRoutes {
  static const String group_list = 'group_list/';
  static const String add_group = 'group_list/add_group/';
  static const String task_list = 'group_list/task_list/';
  static const String add_task = 'group_list/tasks_list/add_task/';
}

class MainNavigation {
  final initialRoute = MainNavigationOfRoutes.group_list;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationOfRoutes.group_list: (context) => const GroupListScreen(),
    MainNavigationOfRoutes.add_group: (context) => const AddGroupScreen(),
  };

  Route<Object>? onGenerateRoute(RouteSettings settings) {
    final configuration = settings.arguments as TaskScreenConfiguration;
    switch (settings.name) {
      case MainNavigationOfRoutes.task_list:
        return MaterialPageRoute(
            builder: (context) => TaskScreen(configuration: configuration));

      case MainNavigationOfRoutes.add_task:
        return MaterialPageRoute(
            builder: (context) => AddTaskScreen(groupKey: configuration.groupKey));

      default:
        return MaterialPageRoute(builder: (context) => Text('data'));
    }
  }

  final onUnknownRoute = (RouteSettings settings) {
    return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => Scaffold(
                body: Center(
                    child: Column(
              children: [
                Text('Page not found \n'),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(MainNavigationOfRoutes.group_list);
                    },
                    child: Text('return for home page'))
              ],
            ))));
  };
}
