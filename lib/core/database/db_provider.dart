import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'db_constants.dart';
import 'db_init.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider instance = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, DBConstants.dbName);

    return await openDatabase(
      path,
      version: DBConstants.dbVersion,
      onCreate: DBInit.createTables,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE users ADD COLUMN image_path TEXT');
        }

        if (oldVersion < 3) {
          await db.execute('ALTER TABLE users ADD COLUMN created_at TEXT');
        }
      },
    );
  }
}