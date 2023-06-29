import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initialize();
    return _database!;
  }

  Future<Database> initialize() async {
    final databasePath = await getDatabasesPath();
    final pathToDatabase = path.join(databasePath, 'my_database.db');

    return await openDatabase(
      pathToDatabase,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions (
            id TEXT PRIMARY KEY,
            title TEXT,
            value REAL,
            date TEXT
          )
        ''');
      },
    );
  }
}
