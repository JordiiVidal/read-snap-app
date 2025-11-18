import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';

class BookStatusSelector extends StatelessWidget {
  final BookStatus selectedStatus;
  final ValueChanged<BookStatus> onStatusChanged;

  const BookStatusSelector({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFormField('Status'),
        Row(
          children: [
            Expanded(
              child: _StatusCard(
                icon: Icons.menu_book_rounded,
                label: 'Reading',
                status: BookStatus.reading,
                isSelected: selectedStatus == BookStatus.reading,
                onTap: () => onStatusChanged(BookStatus.reading),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatusCard(
                icon: Icons.check_circle_rounded,
                label: 'Completed',
                status: BookStatus.completed,
                isSelected: selectedStatus == BookStatus.completed,
                onTap: () => onStatusChanged(BookStatus.completed),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatusCard(
                icon: Icons.flag_rounded,
                label: 'To Read',
                status: BookStatus.toRead,
                isSelected: selectedStatus == BookStatus.toRead,
                onTap: () => onStatusChanged(BookStatus.toRead),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final BookStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusCard({
    required this.icon,
    required this.label,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  Color _getBackgroundColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: 0.3);
    }
    return Theme.of(context).colorScheme.secondary.withValues(alpha: 0.03);
  }

  Color _getBorderColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary;
    }
    return Colors.transparent;
  }

  Color _getIconColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getBorderColor(context),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: _getIconColor(context)),
            const SizedBox(height: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
