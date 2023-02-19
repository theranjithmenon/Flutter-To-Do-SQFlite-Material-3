import 'package:flutter/material.dart';
import 'package:todo_app/sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Map<String, dynamic>> _pendingTasks = [];
  List<Map<String, dynamic>> _completedTasks = [];
  final TextEditingController _title = TextEditingController();

  Future<void> _addItem() async {
    await SQLHelper.createItem(_title.text, 0);
    _refreshData();
  }

  Future<void> _updateItem(int id, String title) async {
    await SQLHelper.updateItem(id, title, 1);
    _refreshData();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    _refreshData();
  }

  void _refreshData() async {
    final dataPending = await SQLHelper.getItem(0);
    final dataCompleated = await SQLHelper.getItem(1);
    setState(() {
      _pendingTasks = dataPending;
      _completedTasks = dataCompleated;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    List pages = [_pendingList(), _compleatedList()];
    return Scaffold(
      appBar: AppBar(
        title: (currentIndex == 0)
            ? Text("Pending Tasks")
            : Text("Completed Tasks"),
        actions: [
          IconButton(
              onPressed: () {
                _showForm();
              },
              icon: Icon(Icons.add_task))
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.timer_outlined),
              label: "Pending",
              selectedIcon: Icon(Icons.timer),
            ),
            NavigationDestination(
              icon: Icon(Icons.task_alt_outlined),
              label: "Completed",
              selectedIcon: Icon(Icons.task_alt),
            ),
          ]),
    );
  }

  _showForm() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              icon: Icon(Icons.add_task),
              title: Text("Add Task"),
              content: TextField(
                controller: _title,
                decoration: InputDecoration(
                    hintText: "Name of task",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              actions: [
                MaterialButton(
                  onPressed: () async {
                    await _addItem();
                    _title.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"),
                )
              ],
            ));
  }

  _pendingList() {
    return (_pendingTasks.length == 0)
        ? Center(child: Text("Add Tasks"))
        : ListView.builder(
            itemCount: _pendingTasks.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            _deleteItem(_pendingTasks[index]["id"]);
                          },
                          icon: Icon(Icons.delete)),
                      title: Text(_pendingTasks[index]["title"]),
                      trailing: IconButton(
                          onPressed: () {
                            _updateItem(_pendingTasks[index]["id"],
                                _pendingTasks[index]["title"]);
                          },
                          icon: (_pendingTasks[index]["isDone"] == 0)
                              ? Icon(
                                  Icons.done,
                                  color: Colors.redAccent,
                                )
                              : Icon(
                                  Icons.done_all,
                                  color: Colors.blueAccent,
                                )),
                    ),
                  ),
                ));
  }

  _compleatedList() {
    return (_completedTasks.length == 0)
        ? Center(child: Text("All tasks Compleated"))
        : ListView.builder(
            itemCount: _completedTasks.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            _deleteItem(_completedTasks[index]["id"]);
                          },
                          icon: Icon(Icons.delete)),
                      title: Text(_completedTasks[index]["title"]),
                    ),
                  ),
                ));
  }
}
