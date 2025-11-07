import 'package:flutter/material.dart';
import 'package:read_snap/config/routes/app_routes.dart';
import 'package:read_snap/shared/widgets/widgets.dart';
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
            // Currently Reading Section
            const SectionHeader(
              title: 'Currently Reading',
              subtitle: 'Pick up where you left off',
              actionWidget: ReadingLimitCounter(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: BookList(
                booksProvider: readingBooksProvider,
                scrollDirection: Axis.horizontal,
                itemVariant: BookListItemVariant.card,
                showAddButton: true,
                onBookTap: (book) => _navigateToDetail(context, book.id),
                onAddTap: () => _navigateToCreate(context),
              ),
            ),
            const SizedBox(height: 40),

            // Library Section
            SectionHeader(
              title: 'Your library',
              subtitle: 'All your saved books',
              actionWidget: IconButton.filled(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () => _navigateToCreate(context),
              ),
            ),
            const SizedBox(height: 10),
            BookList(
              booksProvider: notReadingProvider,
              scrollDirection: Axis.vertical,
              itemVariant: BookListItemVariant.listTile,
              onBookTap: (book) => _navigateToDetail(context, book.id),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String bookId) =>
      AppRoutes.toBookDetail(context, bookId);

  void _navigateToCreate(BuildContext context) =>
      AppRoutes.toBookCreate(context);
}
