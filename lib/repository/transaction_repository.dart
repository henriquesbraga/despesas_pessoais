import 'package:sqflite/sqflite.dart';
import 'package:untitled1/database/databasehelper.dart';
import 'package:untitled1/models/transaction.dart';

class TransactionRepository {
  // Database db =  await _databaseHelper.database;
  // final Database db;

  final DatabaseHelper db;

  TransactionRepository(this.db);

  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    Database d = await db.database;
    return await d.insert("transactions", transaction);
  }

  Future<int> deleteTransaction(String id) async {
    Database d = await db.database;
    return await d.delete(
      "transactions",
      where: "id = ?",
      whereArgs: [id]
    );
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    Database d = await db.database;
    return d.query("transactions");
  }
}