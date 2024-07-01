import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;
  TodoList({super.key, required this.todoList, required this.updateLocalData});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void onItemclicked({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.todoList.removeAt(index);
                });
                widget.updateLocalData();
                Navigator.pop(context);
              },
              child: Text("Mark as Done"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.amber,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? Center(child: Text("No Items Found. !"))
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.deepOrange,
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    onItemclicked(index: index);
                  },
                  title: Text(widget.todoList[index]),
                ),
              );
            });
  }
}
