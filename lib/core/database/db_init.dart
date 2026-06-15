import 'package:sqflite/sqflite.dart';
import 'db_constants.dart';

class DBInit {
  static Future<void> createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBConstants.userTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        phone TEXT,
        created_at TEXT NOT NULL
      )
    ''');
  }
}