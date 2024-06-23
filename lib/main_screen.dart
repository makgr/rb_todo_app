import 'package:flutter/material.dart';
import 'package:rb_todo_app/addToDo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                      return Container(
                        padding: EdgeInsets.all(20),
                        height: 200,
                        child: AddToDo(),
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
      body: Container(),
    );
  }
}
