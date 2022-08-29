import '/repositories/DatabaseConnection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _databaseConnection = DatabaseConnection();

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _databaseConnection.setDatabase();
    return _database!;
  }

  isnertDatabase(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readSelectedData(status) async {
    var connection = await database;
    return await connection
        .rawQuery("select * from tasks where status = $status");
  }

  deleteItem(table, id) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM tasks WHERE id = $id");
  }

  updateItem(id, status) async {
    var connection = await database;
    return await connection
        .rawUpdate("UPDATE tasks SET status = $status WHERE id = $id");
  }
}
