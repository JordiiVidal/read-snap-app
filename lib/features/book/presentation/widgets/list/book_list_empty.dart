import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListEmpty extends StatelessWidget {
  const BookListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: BookListEmptyItem(),
    );
  }
}

class BookListEmptyItem extends StatelessWidget {
  const BookListEmptyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.all(4),
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

  void _navigateToCreate(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookCreatePage()));
  }
}
