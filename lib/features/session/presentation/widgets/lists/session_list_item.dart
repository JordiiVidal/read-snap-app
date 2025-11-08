import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/features/session/domain/domain.dart';
import 'package:read_snap/shared/utils/utils.dart';
import 'package:read_snap/shared/widgets/display/display.dart';

class SessionListItem extends StatelessWidget {
  final SessionEntity session;

  const SessionListItem(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final timeFormatter = DateFormat('HH:mm');

    final dateDisplay = dateFormatter.format(session.sessionDate);
    final timeDisplay = timeFormatter.format(session.sessionDate);
    final durationDisplay = formatMinutesToTime(session.minutesRead);
    final pagesDisplay = '${session.startPage} - ${session.endPage}';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      // Title: Date + Time
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: dateDisplay,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (timeDisplay != '00:00') ...[
              const TextSpan(text: '  '),
              TextSpan(
                text: timeDisplay,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ],
        ),
      ),

      // Subtitle: Pages + Duration
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Wrap(
          spacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Pages indicator
            _InfoChip(
              icon: Icons.menu_book,
              label: 'Pages',
              value: pagesDisplay,
            ),

            // Duration indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                DisplayTime(
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

      // Trailing: Pages read count
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            session.pagesRead.toString(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'pages read',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ========== Info Chip Component ==========
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
