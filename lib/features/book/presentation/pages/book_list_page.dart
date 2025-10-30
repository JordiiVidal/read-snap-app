import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const SectionHeader(
              title: 'Currently Reading',
              subtitle: 'Pick up where you left off',
            ),
            const SizedBox(height: 20),

            // Reading List
            SizedBox(height: 300, child: BookList()),
            const SizedBox(height: 40),

            // Header
            SectionHeader(
              title: 'Your library',
              subtitle: 'All your saved books',
              actionWidget: FilledButton(
                style: FilledButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(4),
                ),
                child: Icon(Icons.add, size: 18),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BookCreatePage()),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Library
            BookLibrary(notReadingProvider),
          ],
        ),
      ),
    );
  }
}
