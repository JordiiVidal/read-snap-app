import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/widgets.dart';

class SessionListEmpty extends StatelessWidget {
  const SessionListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyState(
        title: 'No sessions yet',
        message: 'Start tracking your reading by adding your first session',
      ),
    );
  }
}
