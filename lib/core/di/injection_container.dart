import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/database/database_helper.dart';
import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/session/data/data.dart';
import 'package:read_snap/features/session/domain/domain.dart';
import 'package:sqflite/sqflite.dart';

/* ============================================================ */
/*                        DATABASE                              */
/* ============================================================ */

final databaseProvider = FutureProvider<Database>((ref) async {
  DatabaseHelper.registerTableCreation(createBookTable);
  DatabaseHelper.registerTableCreation(createSessionTable);
  final dbHelper = DatabaseHelper();
  return await dbHelper.database;
});

/* ============================================================ */
/*                    DOMAIN SERVICES                           */
/* ============================================================ */

final bookValidatorServiceProvider = Provider<BookValidatorService>((ref) {
  return const BookValidatorService();
});

/* ============================================================ */
/*                      REPOSITORIES                            */
/* ============================================================ */

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final database = ref.watch(databaseProvider).value;
  if (database == null) {
    throw Exception('Database not initialized for BookRepository');
  }
  return BookRepositoryImpl(database);
});

final bookSearchRepositoryProvider = Provider<BookSearchRepository>((ref) {
  return BookSearchRepositoryImpl();
});

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final database = ref.watch(databaseProvider).value;
  if (database == null) {
    throw Exception('Database not initialized for SessionRepository');
  }
  return SessionRepositoryImpl(database);
});

/* ============================================================ */
/*                     BOOK USE CASES                           */
/* ============================================================ */

final createBookUseCaseProvider = Provider<CreateBookUseCase>((ref) {
  return CreateBookUseCase(
    ref.watch(bookRepositoryProvider),
    ref.watch(bookValidatorServiceProvider),
    ref.watch(checkReadingLimitUseCaseProvider),
    ref.watch(checkBookUniquenessUseCaseProvider),
  );
});

final updateBookUseCaseProvider = Provider<UpdateBookUseCase>((ref) {
  return UpdateBookUseCase(
    ref.watch(bookRepositoryProvider),
    ref.watch(bookValidatorServiceProvider),
  );
});

final getBooksUseCaseProvider = Provider<GetBooksUseCase>((ref) {
  return GetBooksUseCase(ref.watch(bookRepositoryProvider));
});

final getBookByIdUseCaseProvider = Provider<GetBookByIdUseCase>((ref) {
  return GetBookByIdUseCase(ref.watch(bookRepositoryProvider));
});

final checkBookUniquenessUseCaseProvider = Provider<CheckBookUniquenessUseCase>(
  (ref) {
    return CheckBookUniquenessUseCase(ref.watch(bookRepositoryProvider));
  },
);

final deleteBookUseCaseProvider = Provider<DeleteBookUseCase>((ref) {
  return DeleteBookUseCase(ref.watch(bookRepositoryProvider));
});

final checkReadingLimitUseCaseProvider = Provider<CheckReadingLimitUseCase>((
  ref,
) {
  return CheckReadingLimitUseCase(ref.watch(bookRepositoryProvider));
});

/* ============================================================ */
/*                     SESSION USE CASES                        */
/* ============================================================ */

final saveSessionUseCaseProvider = Provider<SaveSessionUseCase>((ref) {
  return SaveSessionUseCase(
    ref.watch(sessionRepositoryProvider),
    ref.watch(bookRepositoryProvider),
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
