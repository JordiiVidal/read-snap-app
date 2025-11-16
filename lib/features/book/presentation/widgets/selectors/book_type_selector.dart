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
                icon: Icons.chrome_reader_mode_sharp,
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
    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      label: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, size: 25, color: isSelected ? Colors.white : Colors.black),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onSelected: (_) => onTap(),
    );
  }
}
