import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/common/utils/utils.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/domain/entities/session_entity.dart';

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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: '  '),
            if (timeDisplay != '00:00')
              TextSpan(
                text: timeDisplay,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 10,
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
            // Pages
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.menu_book, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('Pages', style: TextStyle(fontSize: 10)),
                const SizedBox(width: 4),
                Text(
                  pagesDisplay,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Timer
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                TimeDisplay(
                  durationDisplay,
                  valueFontSize: 13,
                  unitFontSize: 10,
                  shortText: true,
                  spaceBetween: 4,
                ),
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
          ),
          const Text(
            'pages read',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
