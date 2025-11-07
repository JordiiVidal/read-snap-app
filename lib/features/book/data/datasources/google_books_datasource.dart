import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:read_snap/features/book/data/data.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class GoogleBooksDatasource {
  static const String _authority = 'www.googleapis.com';
  static const String _path = '/books/v1/volumes';

  Future<List<BookEntity>> searchBooks(String query) async {
    final Map<String, dynamic> queryParameters = {
      'q': query,
      'maxResults': '10',
      'printType': 'books',
      'filter': 'partial',
    };

    final uri = Uri.https(_authority, _path, queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List items = data['items'] ?? [];

      return items.map((item) {
        return GoogleBooksMapper.fromGoogleBooksJson(item);
      }).toList();
    } else {
      throw Exception(
        'Failed to load books: HTTP Status ${response.statusCode}',
      );
    }
  }
}
