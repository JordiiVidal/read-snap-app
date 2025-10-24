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
              child: const Text(
                'Reading Books',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Reading List
            SizedBox(height: 350, child: BookList(readingBooksProvider)),
            SizedBox(height: 20),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Library',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Library
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Expanded(child: BookLibrary(notReadingProvider)),
            ),
          ],
        ),
      ),
    );
  }
}
