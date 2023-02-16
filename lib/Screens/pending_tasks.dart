import 'package:flutter/material.dart';

class PendingTasks extends StatefulWidget {
  const PendingTasks({Key? key}) : super(key: key);

  @override
  State<PendingTasks> createState() => _PendingTasksState();
}

class _PendingTasksState extends State<PendingTasks> {
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Pending Tasks"),);
  }
}
