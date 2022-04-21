import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/home_page/todo_provider.dart';

import '../entity/todo_dataclass.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final model = TodoModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
        centerTitle: true,
      ),
      body: TodoProvider(model: model, child: const _TodoListWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('todo_list/add_todo');
          //,MaterialPageRoute(builder: (context) => AddTodoScreen())
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _TodoListWidget extends StatelessWidget {
  const _TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoCount = TodoProvider.of(context)?.model.todoList.length ?? 0;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey.withOpacity(0.1), thickness: 1);
          },
          itemCount: todoCount,
          itemBuilder: (BuildContext context, int index) {
            final TodoDataClass itemTodo =
                TodoProvider.of(context)!.model.todoList[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      TodoProvider.of(context)!.model.deleteTodoFromHive(index);
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: 'Share',
                  ),
                ],
              ),
              child: ListTile(
                  onTap: () {},
                  leading: Text(itemTodo.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                    splashRadius: 20,
                  )),
            );
          }),
    );
  }
}
