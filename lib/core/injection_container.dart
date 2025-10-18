import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/database_helper.dart';
import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/session/data/data.dart';
import 'package:read_snap/features/session/dominio/domain.dart';
import 'package:sqflite/sqflite.dart';

/* Database */
final databaseProvider = FutureProvider<Database>((ref) async {
  DatabaseHelper.registerTableCreation(createBookTable);
  DatabaseHelper.registerTableCreation(createSessionTable);
  final dbHelper = DatabaseHelper();
  return await dbHelper.database;
});

/* Book */
/* Repositories */
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final database = ref.watch(databaseProvider).value;
  if (database == null) {
    throw Exception('Database not initialized for BookRepository');
  }
  return BookRepositoryImpl(database);
});
/* Use Cases */
final getBooksUseCaseProvider = Provider<GetBooksUseCase>((ref) {
  return GetBooksUseCase(ref.watch(bookRepositoryProvider));
});

final saveBookUseCaseProvider = Provider<SaveBookUseCase>((ref) {
  return SaveBookUseCase(ref.watch(bookRepositoryProvider));
});

final getBookByIdUseCaseProvider = Provider<GetBookByIdUseCase>((ref) {
  return GetBookByIdUseCase(ref.watch(bookRepositoryProvider));
});

final deleteBookUseCaseProvider = Provider<DeleteBookUseCase>((ref) {
  return DeleteBookUseCase(ref.watch(bookRepositoryProvider));
});

/* Session */
/* Repositories */
final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final database = ref.watch(databaseProvider).value;
  if (database == null) {
    throw Exception('Database not initialized for SessionRepository');
  }
  return SessionRepositoryImpl(database);
});
/* Use Cases */
final saveSessionUseCaseProvider = Provider<SaveSessionUseCase>((ref) {
  return SaveSessionUseCase(ref.watch(sessionRepositoryProvider));
});
final getSessionsUseCaseProvider = Provider<GetSessionsUseCase>((ref) {
  return GetSessionsUseCase(ref.watch(sessionRepositoryProvider));
});
