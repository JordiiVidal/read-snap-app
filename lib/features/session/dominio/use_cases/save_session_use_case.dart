import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/session/dominio/domain.dart';
import 'package:uuid/uuid.dart';

class SaveSessionUseCase {
  final SessionRepository _sessionRepository;
  final BookRepository _bookRepository;

  SaveSessionUseCase(this._sessionRepository, this._bookRepository);

  Future<void> call(SessionEntity session) async {
    // Validations
    _validateSession(session);

    // Business logic
    SessionEntity sessionToSave = _applyBusinessLogic(session);
    BookEntity bookToUpdate = await _appBookBusinessLogic(session);

    // Persistence
    if (session.id.isNotEmpty) {
      // Update
      sessionToSave = sessionToSave.copyWith(updatedAt: DateTime.now());
    } else {
      // Create
      final now = DateTime.now();
      sessionToSave = sessionToSave.copyWith(
        id: const Uuid().v4(),
        createdAt: now,
        updatedAt: now,
      );
    }

    await _bookRepository.updateBook(bookToUpdate);
    await _sessionRepository.saveSession(sessionToSave);
  }

  SessionEntity _applyBusinessLogic(SessionEntity session) {
    final calculatedPages = session.endPage - session.startPage;

    return session.copyWith(pagesRead: calculatedPages);
  }

  Future<BookEntity> _appBookBusinessLogic(SessionEntity session) async {
    final book = await _bookRepository.getBookById(session.bookId);
    final isCompleted = session.endPage >= book.totalPages;

    // Validations
    _validateBook(book, session);

    return book.copyWith(
      currentPage: session.endPage,
      status: isCompleted ? BookStatus.completed : BookStatus.reading,
      finishedAt: isCompleted ? DateTime.now() : book.finishedAt,
      updatedAt: DateTime.now(),
    );
  }

  void _validateBook(BookEntity book, SessionEntity session) {
    final isRestart = session.startPage == 0;
    if (book.status == BookStatus.completed) {
      throw ArgumentError('The book is already completed.');
    }
    if (session.startPage < book.currentPage && !isRestart) {
      throw ArgumentError(
        'The session start page must be greater to the book current page.',
      );
    }
    if (session.endPage < book.currentPage && !isRestart) {
      throw ArgumentError(
        'The session end page must be greater than the book current page.',
      );
    }
    if (session.endPage > book.totalPages) {
      throw ArgumentError(
        'The session end page must be less than the book total pages.',
      );
    }
  }

  void _validateSession(SessionEntity session) {
    if (session.endPage < session.startPage) {
      throw ArgumentError(
        'The end page must be strictly greater than the start page.',
      );
    }
    if (session.endPage == 0) {
      throw ArgumentError('The end page must be greater than 0.');
    }
    if (session.minutesRead <= 0) {
      throw ArgumentError('The session must be at least one minute long.');
    }
    if (session.sessionDate.isAfter(DateTime.now())) {
      throw ArgumentError('The session date cannot be in the future.');
    }
  }
}
