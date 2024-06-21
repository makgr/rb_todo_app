import 'package:flutter/material.dart';

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
                      return Container();
                    });
              },
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
      body: InkWell(onTap: () {}, child: Text("body")),
    );
  }
}
