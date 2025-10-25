import 'package:flutter/material.dart';
import 'package:read_snap/common/widgets/widgets.dart';

class BookListLoading extends StatelessWidget {
  const BookListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      separatorBuilder: (context, index) => const SizedBox(width: 16.0),
      itemBuilder: (ctx, i) => const BookListLoadingItem(),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(width: 40, child: SkeletonLine()),
          ),
          SizedBox(height: 8),

          // Title
          SizedBox(width: 150, child: SkeletonLine()),
          SizedBox(height: 4),

          // Author
          SizedBox(width: 100, child: SkeletonLine()),
          SizedBox(height: 18),

          Spacer(),

          // Progress
          SkeletonLine(),
        ],
      ),
    );
  }
}
