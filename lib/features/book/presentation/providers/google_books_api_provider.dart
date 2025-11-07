import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/data/data.dart';

final googleBooksApiProvider = Provider<GoogleBooksApi>((ref) {
  return GoogleBooksApi();
});
