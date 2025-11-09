import 'package:read_snap/features/category/data/data.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createCategoryTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${CategoryMapper.table} (
        ${CategoryMapper.id} TEXT PRIMARY KEY,
        ${CategoryMapper.name} TEXT NOT NULL,
        ${CategoryMapper.selectedByUser} INTEGER NOT NULL,
        ${CategoryMapper.iconEmoji} TEXT,
        ${CategoryMapper.aliases} TEXT NOT NULL,
        ${CategoryMapper.createdAt} INTEGER NOT NULL,
        ${CategoryMapper.updatedAt} INTEGER NOT NULL
      )
  ''');

  await db.execute('''
    CREATE UNIQUE INDEX idx_category_name 
    ON ${CategoryMapper.table}(${CategoryMapper.name})
  ''');
}
