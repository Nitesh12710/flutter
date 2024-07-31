import 'package:flutter/material.dart';
import 'package:first_projecti/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onTodoChange;
  final onDelete;

  const ToDoItem({Key? key, required this.todo,required this.onTodoChange,
  required this.onDelete,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChange(todo);

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
         todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.todoText ?? 'No title', // Handle null todoText gracefully
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(todo.id);
            },
            iconSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
