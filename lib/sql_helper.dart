import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
    CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    isDone INTEGER
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('tasks.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String title, int isDone) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'isDone': isDone};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title, int isDone) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'isDone': isDone};
    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }
  static Future<void> deleteItem(int id)async{
    final db = await SQLHelper.db();
    try{
      await db.delete("items",where: "id = ?",whereArgs: [id]);
    } catch(err){
      debugPrint("$err");
    }
  }
}
