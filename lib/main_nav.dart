import 'package:flutter/material.dart';
import 'package:todo_app/Screens/checked_tasks.dart';
import 'package:todo_app/Screens/pending_tasks.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List pages = [PendingTasks(), CheckedTasks()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo"),
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        child: const Icon(Icons.add_task),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.timer_outlined), label: "ToDo"),
          NavigationDestination(
              icon: Icon(Icons.task_alt_outlined), label: "Completed"),
        ],
      ),
    );
  }

  _addTask() {
    TextEditingController taskName = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              icon: Icon(Icons.add_task),
              title: Text("Add Task"),
              content: TextField(
                controller: taskName,
                decoration: InputDecoration(
                    hintText: "Name of task",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                  },
                  child: Text("Add"),
                )
              ],
            ));
  }
}
