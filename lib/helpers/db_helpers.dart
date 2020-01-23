import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBhelpers {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'task.db'), version: 1,
        onCreate: (sql.Database db, int version) {
      return db.execute(
          'CREATE TABLE task_list (id TEXT PRIMARY KEY,name TEXT,isDone INTEGER,color INTEGER)');
    });
  }

  static Future<void> insertTask(
      String tableName, Map<String, dynamic> task) async {
    final db = await DBhelpers.database();
    final insertInfo = await db.insert(tableName, task,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('Data Inserted : ' + insertInfo.toString());
    await db.close();
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await DBhelpers.database();
    List list = await db.query(tableName);
    await db.close();
    return list;
  }

  static Future<void> deleteTask(String tableName, String id) async {
    final db = await DBhelpers.database();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateTask(
      String tableName, Map<String, dynamic> updateTask) async {
    final db = await DBhelpers.database();
    final updateInfo = await db.update(tableName, updateTask,
        where: 'id = ?', whereArgs: [updateTask['id']]);
        print(updateInfo);
  }
}
