import 'package:path/path.dart';
import 'package:read_snap/features/book/data/models/book_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'readsnap_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableBooks (
        ${BookModel.id} TEXT PRIMARY KEY,
        ${BookModel.name} TEXT NOT NULL,
        ${BookModel.author} TEXT NOT NULL,
        ${BookModel.totalPages} INTEGER NOT NULL,
        ${BookModel.currentPage} INTEGER,
        ${BookModel.status} TEXT NOT NULL,
        ${BookModel.color} TEXT NOT NULL,
        ${BookModel.createdAt} INTEGER NOT NULL,
        ${BookModel.updatedAt} INTEGER NOT NULL
      )
    ''');
  }
}
