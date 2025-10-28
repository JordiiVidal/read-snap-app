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
final createBookUseCaseProvider = Provider<CreateBookUseCase>((ref) {
  return CreateBookUseCase(
    ref.watch(bookRepositoryProvider),
    BookValidatorService(),
  );
});

final updateBookUseCaseProvider = Provider<UpdateBookUseCase>((ref) {
  return UpdateBookUseCase(
    ref.watch(bookRepositoryProvider),
    BookValidatorService(),
  );
});

final getBooksUseCaseProvider = Provider<GetBooksUseCase>((ref) {
  return GetBooksUseCase(ref.watch(bookRepositoryProvider));
});

final getBookByIdUseCaseProvider = Provider<GetBookByIdUseCase>((ref) {
  return GetBookByIdUseCase(ref.watch(bookRepositoryProvider));
});

final getBookByNameAndAuthorUseCaseProvider =
    Provider<GetBookByNameAndAuthorUseCase>((ref) {
      return GetBookByNameAndAuthorUseCase(ref.watch(bookRepositoryProvider));
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
  return SaveSessionUseCase(
    ref.watch(sessionRepositoryProvider),
    ref.watch(bookRepositoryProvider),
    ref,
  );
});
final getSessionsByBookUseCaseProvider = Provider<GetSessionsByBookUseCase>((
  ref,
) {
  return GetSessionsByBookUseCase(ref.watch(sessionRepositoryProvider));
});
final getTotalReadingTimeUseCaseProvider = Provider<GetTotalReadingTimeUseCase>(
  (ref) {
    return GetTotalReadingTimeUseCase(ref.watch(sessionRepositoryProvider));
  },
);
