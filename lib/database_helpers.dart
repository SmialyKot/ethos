import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableMoods = 'dates';
final String columnId = '_id';
final String columnDate = 'date';
final String columnMood = 'mood';

// data model class
class Mood {

  int id;
  String date;
  int mood;

  Mood();

  // convenience constructor to create a Mood object
  Mood.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    date = map[columnDate];
    mood = map[columnMood];
  }

  // convenience method to create a Map from this Mood object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnDate: date,
      columnMood: mood
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database

  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    print(documentsDirectory.path);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableMoods (
                $columnId INTEGER PRIMARY KEY,
                $columnDate TEXT NOT NULL,
                $columnMood INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Mood date) async {
    Database db = await database;
    int id = await db.insert(tableMoods, date.toMap());
    return id;
  }

  // Deletes the whole database
  Future deleteDatabase() async {
    var dbClient = await database;
    return await dbClient.rawDelete('DELETE FROM $tableMoods');
  }

  //
  Future lastRowID() async {
    var dbClient = await database;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT last_insert_rowid()'));
  }

  Future<Mood> queryMood(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableMoods,
        columns: [columnId, columnDate, columnMood],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Mood.fromMap(maps.first);
    }
    return null;
  }

}