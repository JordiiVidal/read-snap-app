import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            // Header
            const SectionHeader(
              title: 'Currently Reading',
              subtitle: 'Keep up your progress',
            ),

            // Reading List
            SizedBox(height: 300, child: BookList(readingBooksProvider)),

            // Header
            const SectionHeader(
              title: 'Your library',
              subtitle: 'All your saved books',
            ),

            // Library
            BookLibrary(notReadingProvider),
          ],
        ),
      ),
    );
  }
}
