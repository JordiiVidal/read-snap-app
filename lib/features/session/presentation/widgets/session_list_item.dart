import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/features/session/dominio/entities/session_entity.dart';

class SessionListItem extends StatelessWidget {
  final SessionEntity session;

  const SessionListItem(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final timeFormatter = DateFormat('HH:mm');
    final dateDisplay = dateFormatter.format(session.sessionDate);
    final timeDisplay = timeFormatter.format(session.sessionDate);
    final durationDisplay = formatMinutesToTime(session.minutesRead);
    final pagesDisplay = '${session.startPage} - ${session.endPage}';

    return ListTile(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: dateDisplay,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const TextSpan(text: ' '),
            TextSpan(
              text: timeDisplay,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Wrap(
          spacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.menu_book, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(pagesDisplay, style: const TextStyle(fontSize: 13)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                //Text(durationDisplay, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ],
        ),
      ),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            session.pagesRead.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Text(
            'págs.',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
