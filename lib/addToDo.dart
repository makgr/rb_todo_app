import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController toDoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("add to do"),
        TextField(
          controller: toDoText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            hintText: "Type your task here",
          ),
        ),
        ElevatedButton(onPressed: () {}, child: Text("Add")),
      ],
    );
  }
}
