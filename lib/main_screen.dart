import 'package:flutter/material.dart';
import 'package:rb_todo_app/addToDo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/todoList.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }

  void addToDo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already exist."),
              content: Text("This data already exist."),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                ),
              ],
            );
          });
      return;
    }
    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('todoList') ?? []).toList();
    setState(() {});
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
      body: TodoList(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
    );
  }
}
