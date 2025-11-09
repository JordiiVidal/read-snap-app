import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

typedef TableCreationFunction = Future<void> Function(Database db);

class DatabaseHelper {
  static const int databaseVersion = 5;
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
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    for (final func in _tableCreationFunctions) {
      await func(db);
    }
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < databaseVersion) {
      for (final func in _tableCreationFunctions) {
        try {
          await func(db);
        } catch (e) {
          if (!e.toString().contains('already exists')) {
            rethrow;
          }
        }
      }
    }
  }
}
