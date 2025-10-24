import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookListEmpty extends StatelessWidget {
  const BookListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 1,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: BookListEmptyItem(),
      ),
    );
  }
}

class BookListEmptyItem extends StatelessWidget {
  const BookListEmptyItem({super.key});

  void _navigateToCreate(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BookFormPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
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
