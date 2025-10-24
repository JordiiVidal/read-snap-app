import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/dashed_border_container.dart';
import 'package:read_snap/features/book/presentation/pages/book_form_page.dart';

class BookLibraryEmpty extends StatelessWidget {
  const BookLibraryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BookLibraryEmptyItem(),
      ),
    );
  }
}

class BookLibraryEmptyItem extends StatelessWidget {
  const BookLibraryEmptyItem({super.key});

  void _navigateToCreate(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookFormPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black.withValues(alpha: 0.06),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: DashedBorderContainer(
          child: InkWell(
            onTap: () => _navigateToCreate(context),
            child: const Center(
              child: Icon(Icons.add, color: Colors.grey, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}
