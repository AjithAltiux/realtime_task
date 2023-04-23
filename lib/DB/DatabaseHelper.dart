import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:realtime_innovationstask/Models/EmpModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "mydatabase.db";
  static const _databaseVersion = 1;

  static const table = 'emp_table';

  static const columnID = 'id';
  static const columnName = 'empname';
  static const columnRole = 'role';
  static const columnfromDate = 'fromDate';
  static const columntoDate = 'toDate';
  static const columnisDeleted = 'isDeleted';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // create the table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnID TEXT PRIMARY KEY,
            $columnName TEXT,
            $columnRole TEXT NOT NULL UNIQUE,
            $columnfromDate TEXT NOT NULL,
            $columntoDate TEXT NOT NULL,
            $columnisDeleted INTEGER NOT NULL
          )
          ''');
  }

  // insert a user into the database
  Future<int> insert(EmpModel user) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get All the Users in the table
  Future<List<EmpModel>> getAllUsers(int isDelete) async {
    final db = await database;
    final result = await db
        .query(table, where: '$columnisDeleted = ?', whereArgs: [isDelete]);
    print(result.toString());
    return result.map((json) => EmpModel.fromMap(json)).toList();
  }

  // Update the user data based on the user id
  Future<int> updateUser(EmpModel user) async {
    final db = await database;
    return await db.update(table, user.toMap(),
        where: '$columnID = ?', whereArgs: [user.id]);
  }

  // Delet the user from the table
  Future<int> deleteUser(EmpModel user) async {
    final db = await database;
    return await db.delete(table, where: '$columnID = ?', whereArgs: [user.id]);
  }

  // login the user
  Future<EmpModel?> queryUser(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table,
        where:
            '$columnID = ?  AND $columnisDeleted = ?',
        whereArgs: [ id,0]);
    if (maps.isNotEmpty) {
      return EmpModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Get the user details based on isdeleted condition
  Future<EmpModel?> queryUserDetails(String userId, int isDeleted) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table,
        where: '$columnID = ? AND $columnisDeleted = ?',
        whereArgs: [userId, isDeleted]);
    if (maps.isNotEmpty) {
      return EmpModel.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
