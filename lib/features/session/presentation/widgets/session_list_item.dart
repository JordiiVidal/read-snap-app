import 'package:flutter/material.dart';
import 'package:read_snap/features/session/dominio/entities/session_entity.dart';

class SessionListItem extends StatelessWidget {
  final SessionEntity session;

  const SessionListItem(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = session.startedAt; // TODO
    final timeDisplay = '${session.minutesRead} min';
    final pagesDisplay = '${session.pagesRead} pages';

    return ListTile(
      title: Text(
        pagesDisplay,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('$formattedDate - $timeDisplay'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      leading: const Icon(Icons.menu_book),
    );
  }
}
