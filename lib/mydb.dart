import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class mydatabase
{
   Future<Database>database()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');


    // open the database
    Database database = await openDatabase(path, version: 2,
        onUpgrade: (db, oldVersion, newVersion) async {
          await db.execute(
             'alter table student add fav integer default 0');
        },
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'create table student (id integer primary key,name text,contact text,mail text)');
          await db.execute(
              'create table fav (id integer primary key,name text,contact text,mail text)');
        });
    return database;
  }
}