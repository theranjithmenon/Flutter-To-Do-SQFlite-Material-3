import 'package:flutter/material.dart';
class CheckedTasks extends StatefulWidget {
  const CheckedTasks({Key? key}) : super(key: key);

  @override
  State<CheckedTasks> createState() => _CheckedTasksState();
}

class _CheckedTasksState extends State<CheckedTasks> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Completed Tasks"),);
  }
}
