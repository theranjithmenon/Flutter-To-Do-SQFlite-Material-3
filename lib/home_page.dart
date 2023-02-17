import 'package:flutter/material.dart';
import 'package:todo_app/sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  final TextEditingController _title = TextEditingController();

  Future<void> _addItem() async {
    await SQLHelper.createItem(_title.text, 0);
    _refreshJournels();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _journals[id]["title"], 1);
    _refreshJournels();
  }

  void _deleteItem(int id) async{
    await SQLHelper.deleteItem(id);
    _refreshJournels();
  }

  void _refreshJournels() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              child: Text("${_journals.length}"),
            ),
          )
        ],
      ),
      body: (_journals.length == 0)
          ? Center(child: Text("Add Tasks"))
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: IconButton(onPressed: (){
                          _deleteItem(_journals[index]["id"]);
                        }, icon: Icon(Icons.delete)),
                        title: Text(_journals[index]["title"]),
                        trailing: IconButton(
                            onPressed: () {
                              _updateItem(index);
                            },
                            icon: (_journals[index]["isDone"] == 0)
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
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm();
        },
        child: Icon(Icons.add_task),
      ),
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
}
