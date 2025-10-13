import 'package:read_snap/features/book/data/models/book_model.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/domain/repositories/book_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

class BookRepositoryImpl implements BookRepository {
  final Database _db;
  final BookModel _bookModel = BookModel();

  BookRepositoryImpl(this._db);

  @override
  Future<List<BookEntity>> getBooks() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableBooks);
    return List.generate(maps.length, (i) => _bookModel.fromMap(maps[i]));
  }

  @override
  Future<void> addBook(BookEntity book) async {
    final bookToCreate = book.copyWith(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _db.insert(
      tableBooks,
      _bookModel.toMap(bookToCreate),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateBook(BookEntity book) async {
    final bookToUpdate = book.copyWith(updatedAt: DateTime.now());
    await _db.update(
      tableBooks,
      _bookModel.toMap(bookToUpdate),
      where: '${BookModel.id} = ?',
      whereArgs: [bookToUpdate.id],
    );
  }

  @override
  Future<void> deleteBook(String id) async {
    await _db.delete(tableBooks, where: '${BookModel.id} = ?', whereArgs: [id]);
  }

  @override
  Future<BookEntity> getBookById(String id) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      tableBooks,
      where: '${BookModel.id} = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw ArgumentError('Book not found');
    }
    return _bookModel.fromMap(maps.first);
  }
}
