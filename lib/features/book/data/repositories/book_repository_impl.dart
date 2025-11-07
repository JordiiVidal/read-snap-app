import 'package:sqflite/sqlite_api.dart';
import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookRepositoryImpl implements BookRepository {
  final Database _db;

  BookRepositoryImpl(this._db);

  @override
  Future<List<BookEntity>> getBooks() async {
    final List<Map<String, dynamic>> maps = await _db.query(BookMapper.table);
    return maps.map(BookMapper.fromMap).toList();
  }

  @override
  Future<void> addBook(BookEntity book) async {
    await _db.insert(
      BookMapper.table,
      BookMapper.toMap(book),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateBook(BookEntity book) async {
    await _db.update(
      BookMapper.table,
      BookMapper.toMap(book),
      where: '${BookMapper.id} = ?',
      whereArgs: [book.id],
    );
  }

  @override
  Future<void> deleteBook(String id) async {
    await _db.delete(
      BookMapper.table,
      where: '${BookMapper.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<BookEntity> getBookById(String id) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      BookMapper.table,
      where: '${BookMapper.id} = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw BookNotFoundException();
    }
    return BookMapper.fromMap(maps.first);
  }

  @override
  Future<BookEntity?> getBookByNameAndAuthor(
    String title,
    String author,
  ) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      BookMapper.table,
      where: '${BookMapper.title} = ? AND ${BookMapper.author} = ?',
      whereArgs: [title, author],
    );
    if (maps.isEmpty) {
      return null;
    }
    return BookMapper.fromMap(maps.first);
  }

  @override
  Future<int> countBooksByStatus(BookStatus status) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      BookMapper.table,
      where: '${BookMapper.status} = ?',
      whereArgs: [status.name],
    );
    return maps.length;
  }
}
