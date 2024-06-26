import 'package:flutter/material.dart';
import 'package:rb_todo_app/addToDo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = ['This is awesome.', 'Amazing'];

  void addToDo({required String todoText}) {
    setState(() {
      todoList.insert(0, todoText);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("RB To Do"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              splashColor: Colors.amber,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 200,
                          child: AddToDo(
                            addToDo: addToDo,
                          ),
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              todoList.removeAt(index);
                            });
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
              },
              title: Text(todoList[index]),
            );
          }),
    );
  }
}
