import 'package:read_snap/features/language/data/data.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createLanguageTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${LanguageMapper.table} (
        ${LanguageMapper.id} TEXT PRIMARY KEY,
        ${LanguageMapper.code} TEXT NOT NULL,
        ${LanguageMapper.name} TEXT NOT NULL,
        ${LanguageMapper.nativeName} TEXT NOT NULL,
        ${LanguageMapper.flag} TEXT NOT NULL,
        ${LanguageMapper.selectedByUser} INTEGER NOT NULL,
        ${LanguageMapper.createdAt} INTEGER NOT NULL,
        ${LanguageMapper.updatedAt} INTEGER NOT NULL
      )
  ''');

  // Índice único para code
  await db.execute('''
    CREATE UNIQUE INDEX idx_language_code 
    ON ${LanguageMapper.table}(${LanguageMapper.code})
  ''');
}

