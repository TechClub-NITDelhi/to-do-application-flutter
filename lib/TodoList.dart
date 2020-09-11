import 'package:flutter/material.dart';
import 'package:todoey/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController titleCtl = new TextEditingController();
  final List<Todo> todos = [];
  Function _toggle(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Function _addTodo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add New Todo'),
            content: TextField(
              controller: titleCtl,
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    final todo = Todo(title: titleCtl.text, isDone: false);
                    todos.add(todo);
                    titleCtl.clear();
                    Navigator.of(context).pop();
                  });
                },
                child: Text('Add'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todoey'),
      ),
      body: todos.isEmpty
          ? Center(
              child: Text('Add a new task'),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      value: todos[index].isDone,
                      onChanged: (value) {
                        setState(() {
                          _toggle(todos[index], value);
                        });
                      },
                      title: Text(
                        todos[index].title,
                        style: todos[index].isDone
                            ? TextStyle(decoration: TextDecoration.lineThrough)
                            : TextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'do this by friday',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
