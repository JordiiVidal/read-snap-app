import 'package:read_snap/features/book/data/data.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createBookTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${BookMapper.table} (
        ${BookMapper.id} TEXT PRIMARY KEY,
        ${BookMapper.externalId} TEXT, 
        ${BookMapper.title} TEXT NOT NULL, 
        ${BookMapper.subtitle} TEXT,
        ${BookMapper.description} TEXT,
        ${BookMapper.publisher} TEXT,
        ${BookMapper.publishedDate} TEXT,
        ${BookMapper.categories} TEXT, 
        ${BookMapper.imageThumbnail} TEXT,
        ${BookMapper.language} TEXT,
        ${BookMapper.author} TEXT NOT NULL, 
        ${BookMapper.totalPages} INTEGER NOT NULL,
        ${BookMapper.currentPage} INTEGER,
        ${BookMapper.status} TEXT NOT NULL,
        ${BookMapper.color} TEXT NOT NULL,
        ${BookMapper.createdAt} INTEGER NOT NULL,
        ${BookMapper.updatedAt} INTEGER NOT NULL,
        ${BookMapper.finishedAt} INTEGER,
        ${BookMapper.startedAt} INTEGER
      )
  ''');
}
