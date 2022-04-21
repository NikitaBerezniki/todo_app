import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class TodoListScreen extends StatelessWidget {
  const TodoListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список задач'),
        centerTitle: true,
      ),
      body: _HomeScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('todo_list/add_todo');
          //,MaterialPageRoute(builder: (context) => AddTodoScreen())
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey.withOpacity(0.1), thickness: 1);
          },
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: 'Share',
                  ),
                ],
              ),
              child: ListTile(
                  onTap: () {},
                  leading: Text('dasdasdas'),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {},
                    splashRadius: 20,
                  )),
            );
          }),
    );
  }
}
