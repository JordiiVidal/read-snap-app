import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

typedef TableCreationFunction = Future<void> Function(Database db);

class DatabaseHelper {
  static Database? _database;
  static final List<TableCreationFunction> _tableCreationFunctions = [];

  static void registerTableCreation(TableCreationFunction func) {
    _tableCreationFunctions.add(func);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'readsnap_database.db');
    return await openDatabase(path, version: 3, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    for (final func in _tableCreationFunctions) {
      await func(db);
    }
  }
}
