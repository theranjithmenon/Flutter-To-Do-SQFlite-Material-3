import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo"),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          destinations:const [
            NavigationDestination(icon: Icon(Icons.timer_outlined), label: "ToDo"),
            NavigationDestination(icon: Icon(Icons.task_alt_outlined), label: "Completed"),
          ]),
    );
  }
}
