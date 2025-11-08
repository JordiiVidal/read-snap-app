import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/cards/cards.dart';
import 'package:read_snap/shared/widgets/loading/loading.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardStat(
      header: const LoadingLine(width: 100, height: 14),
      footer: const LoadingLine(width: 80, height: 14),
      children: const [
        LoadingLine(width: 150, height: 24),
        SizedBox(height: 16),
        LoadingLine(width: 150, height: 24),
      ],
    );
  }
}
