import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mediconnect.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appointments (
        id TEXT PRIMARY KEY,
        doctorName TEXT,
        specialty TEXT,
        dateTime TEXT,
        status TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE vitals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        value TEXT,
        timestamp TEXT
      )
    ''');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
