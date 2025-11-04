import 'package:read_snap/features/book/data/models/book_model.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createBookTable(Database db) async {
  await db.execute('''
      CREATE TABLE ${BookModel.table} (
        ${BookModel.id} TEXT PRIMARY KEY,
        ${BookModel.externalId} TEXT, 
        ${BookModel.title} TEXT NOT NULL, 
        ${BookModel.subtitle} TEXT,
        ${BookModel.description} TEXT,
        ${BookModel.publisher} TEXT,
        ${BookModel.publishedDate} TEXT,
        ${BookModel.categories} TEXT, 
        ${BookModel.imageThumbnail} TEXT,
        ${BookModel.language} TEXT,
        ${BookModel.author} TEXT NOT NULL, 
        ${BookModel.totalPages} INTEGER NOT NULL,
        ${BookModel.currentPage} INTEGER,
        ${BookModel.status} TEXT NOT NULL,
        ${BookModel.color} TEXT NOT NULL,
        ${BookModel.createdAt} INTEGER NOT NULL,
        ${BookModel.updatedAt} INTEGER NOT NULL,
        ${BookModel.finishedAt} INTEGER,
        ${BookModel.startedAt} INTEGER
      )
  ''');
}
