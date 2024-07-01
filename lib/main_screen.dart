import 'package:flutter/material.dart';
import 'package:rb_todo_app/addToDo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(
                  'RB To Do',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://makgr.com"));
              },
              leading: Icon(Icons.person),
              title: Text(
                "About Me",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("mailto:xvirus.bd@gmail.com"));
              },
              leading: Icon(Icons.email_sharp),
              title: Text(
                "Contact",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("RB To Do"),
      ),
      body: TodoList(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
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
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}
