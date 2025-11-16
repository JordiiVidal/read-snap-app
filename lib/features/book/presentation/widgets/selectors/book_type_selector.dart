import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

class BookTypeSelector extends StatelessWidget {
  final BookType selectedType;
  final ValueChanged<BookType> onTypeChanged;
  final String? label;

  const BookTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFormField(label ?? 'Type'),
        Row(
          children: [
            Expanded(
              child: _TypeCard(
                icon: Icons.menu_book_rounded,
                label: 'Paper',
                type: BookType.paper,
                isSelected: selectedType == BookType.paper,
                onTap: () => onTypeChanged(BookType.paper),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TypeCard(
                icon: Icons.tablet_rounded,
                label: 'eBook',
                type: BookType.digital,
                isSelected: selectedType == BookType.digital,
                onTap: () => onTypeChanged(BookType.digital),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final BookType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.label,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getBorderColor(context),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, size: 30, color: _getIconColor(context)),
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
}
