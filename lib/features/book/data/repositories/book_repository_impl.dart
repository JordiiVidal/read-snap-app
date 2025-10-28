import 'package:read_snap/features/book/data/models/book_model.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/domain/services/exceptions.dart';
import 'package:read_snap/features/book/domain/repositories/book_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class BookRepositoryImpl implements BookRepository {
  final Database _db;
  final BookModel _model = BookModel();

  BookRepositoryImpl(this._db);

  @override
  Future<List<BookEntity>> getBooks() async {
    final List<Map<String, dynamic>> maps = await _db.query(BookModel.table);
    return List.generate(maps.length, (i) => _model.fromMap(maps[i]));
  }

  @override
  Future<void> addBook(BookEntity book) async {
    await _db.insert(
      BookModel.table,
      _model.toMap(book),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateBook(BookEntity book) async {
    await _db.update(
      BookModel.table,
      _model.toMap(book),
      where: '${BookModel.id} = ?',
      whereArgs: [book.id],
    );
  }

  @override
  Future<void> deleteBook(String id) async {
    await _db.delete(
      BookModel.table,
      where: '${BookModel.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<BookEntity> getBookById(String id) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      BookModel.table,
      where: '${BookModel.id} = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw BookNotFoundException();
    }
    return _model.fromMap(maps.first);
  }

  @override
  Future<BookEntity?> getBookByNameAndAuthor(String name, String author) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      BookModel.table,
      where: '${BookModel.name} = ? AND ${BookModel.author} = ?',
      whereArgs: [name, author],
    );
    if (maps.isEmpty) {
      return null;
    }
    return _model.fromMap(maps.first);
  }
}
