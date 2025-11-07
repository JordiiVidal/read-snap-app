import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/widgets.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: const SkeletonLine(width: 100, height: 14),
      footer: const SkeletonLine(width: 80, height: 14),
      children: [
        const SkeletonLine(width: 150, height: 24),
        const SizedBox(height: 16),
        const SkeletonLine(width: 150, height: 24),
      ],
    );
  }
}
