class BookNotFoundException implements Exception {}

class ReadingLimitExceededException implements Exception {
  final String message =
      'You can only have a maximum of 3 books in "Reading" status.';
  @override
  String toString() => 'ReadingLimitExceededException: $message';
}

class BookAlreadyExistsException implements Exception {
  final String name;
  final String author;
  BookAlreadyExistsException(this.name, this.author);

  @override
  String toString() =>
      'A book with the name "$name" and author "$author" already exists.';
}
