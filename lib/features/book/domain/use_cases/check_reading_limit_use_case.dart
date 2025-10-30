import 'package:read_snap/features/book/domain/domain.dart';

class CheckReadingLimitUseCase {
  static const int maxReadingBooks = 3;
  final BookRepository _repository;

  CheckReadingLimitUseCase(this._repository);

  Future<void> call() async {
    final currentReadingCount = await _repository.countBooksByStatus(
      BookStatus.reading,
    );

    if (currentReadingCount >= maxReadingBooks) {
      throw ReadingLimitExceededException();
    }
  }
}
