import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleBooksDatasource {
  static const String _authority = 'www.googleapis.com';
  static const String _path = '/books/v1/volumes';

  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
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

      return items.cast<Map<String, dynamic>>();
    } else {
      throw Exception(
        'Failed to load books: HTTP Status ${response.statusCode}',
      );
    }
  }
}
