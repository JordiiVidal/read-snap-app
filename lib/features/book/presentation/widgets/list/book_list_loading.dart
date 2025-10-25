import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';

class BookListLoading extends StatelessWidget {
  const BookListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (ctx, i) => Padding(
        padding: EdgeInsets.only(right: 16.0, left: i == 0 ? 16.0 : 0),
        child: const BookListLoadingItem(),
      ),
    );
  }
}

class BookListLoadingItem extends StatelessWidget {
  const BookListLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status
          const Align(
            alignment: Alignment.topRight,
            child: SizedBox(width: 40, child: SkeletonLine()),
          ),
          const SizedBox(height: 8),

          // Title
          SizedBox(width: 150, child: const SkeletonLine()),
          const SizedBox(height: 4),

          // Author
          SizedBox(width: 100, child: SkeletonLine()),
          const SizedBox(height: 18),

          const Spacer(),

          // Progress
          SkeletonLine(),
        ],
      ),
    );
  }
}
