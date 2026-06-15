import 'package:sqflite/sqflite.dart';

import '../../../../core/database/db_constants.dart';
import '../../../../core/database/db_provider.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  final DBProvider _dbProvider = DBProvider.instance;

  Future<int> registerUser(UserModel user) async {
    final db = await _dbProvider.database;

    return await db.insert(
      DBConstants.userTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> loginUser(
      String email,
      String password,
      ) async {
    final db = await _dbProvider.database;

    final result = await db.query(
      DBConstants.userTable,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await _dbProvider.database;

    final result = await db.query(
      DBConstants.userTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await _dbProvider.database;

    return await db.update(
      DBConstants.userTable,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}