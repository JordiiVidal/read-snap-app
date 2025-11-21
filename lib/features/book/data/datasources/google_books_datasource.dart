import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleBooksDatasource {
  static const String _authority = 'www.googleapis.com';
  static const String _path = '/books/v1/volumes';

  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final Map<String, dynamic> queryParameters = {
      'q': query,
      'maxResults': '20',
      'printType': 'books',
      'filter': 'partial',
      'projection': 'full',
      'orderBy': 'relevance',
    };

    try {
      final uri = Uri.https(_authority, _path, queryParameters);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List items = data['items'] ?? [];

        final validBooks = items
            .where(_hasRequiredFields)
            .toList()
            .cast<Map<String, dynamic>>();

        return validBooks;
      } else {
        throw Exception(
          'Failed to load books: HTTP Status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  bool _hasRequiredFields(dynamic item) {
    final volumeInfo = item['volumeInfo'];
    if (volumeInfo == null) return false;

    final title = volumeInfo['title'] as String?;
    if (title == null || title.trim().isEmpty) return false;

    final authors = volumeInfo['authors'] as List<dynamic>?;
    if (authors == null || authors.isEmpty) return false;

    return true;
  }
}
