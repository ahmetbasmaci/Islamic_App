// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  static const String dbName = 'favorite';
  Future<Database?> get db async {
    if (SqlDb._db == null) {
      SqlDb._db = await _intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> _intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, '$dbName.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    //if you want to upgrade the database
    //you have to change the version number

    Batch batch = db.batch();

    batch.execute("ALTER TABLE notes ADD COLUMN 'title2' TEXT");

    await batch.commit();
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE "$dbName" (
        "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
        "zikrType" INTEGER NOT NULL,
        "title" TEXT NOT NULL,
        "content" TEXT NOT NULL,
        "description" TEXT NOT NULL,
        "numberInQuran" INTEGER,
        "surahNumber" INTEGER,
        "count" INTEGER NOT NULL
      )
    ''');
    print(" onCreate Database =====================================");
  }

/*
  _onCreateMultiTabels(Database db, int version) async {
    //prefer to use this every time
    Batch batch = db.batch();

    batch.execute('''
      CREATE TABLE "$dbName" (
        "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
        "title" TEXT NOT NULL
        "content" TEXT NOT NULL,
      )
    ''');
    // batch.execute('''
    //   CREATE TABLE "student" (
    //     "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    //     "note" TEXT NOT NULL
    //   )
    // ''');

    await batch.commit();
    print(" onCreate =====================================");
  }
*/
  /// read all data from local database
  Future<List<Map>> readData(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  /// insert data to local database
  insertData(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  /// update specific table data from local database
  updateData(String table, Map<String, dynamic> values, String? where) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: where);
    return response;
  }

  /// delete specific table data from local database
  deleteData(String table, String? where) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: where);
    return response;
  }

  /// delete all data from local database
  deleteDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, '$dbName.db');
    _db = null;
    await deleteDatabase(path);

    print(" database deleted =====================================");
  }
}
