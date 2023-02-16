import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class TasksDB {
  static final TasksDB instance = TasksDB._init();

  static Database? _database;

  TasksDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTO_INCREMENT,title TEXT,idDone BOOLEAN)');
  }

  create(TasksDB tasksDB) async {
    final db = await instance.database;
  }

  close() async {
    final db = await instance.database;
    db.close();
  }

}
