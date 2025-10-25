import 'package:flutter/material.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Currently Reading',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Keep up your progress',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Reading List
            SizedBox(height: 300, child: BookList(readingBooksProvider)),
            SizedBox(height: 20),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Text(
                    'Your library',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'All your saved books',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Library
            BookLibrary(notReadingProvider),
          ],
        ),
      ),
    );
  }
}
