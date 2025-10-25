import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const BookForm(this.formKey, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync = ref.watch(bookFormNotifierProvider);
    final notifier = ref.read(bookFormNotifierProvider.notifier);
    // Ahora mismo solo sirve para la creación de nuevos books
    final BookEntity bookState = formAsync.value!;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Select Button Group
          FormLabelField('Status'),
          const SizedBox(height: 8),
          SelectButtonGroup(
            color: bookState.color,
            options: {
              BookStatus.reading.name: 'Reading',
              BookStatus.completed.name: 'Completed',
              BookStatus.toRead.name: 'To Read',
            },
            selectedValues: [bookState.status.name],
            onSelectionChanged: (values) {
              final status = BookStatus.values.firstWhere(
                (status) => status.name == values.first,
              );
              notifier.updateStatus(status);
            },
          ),
          const SizedBox(height: 20),

          // Title Field
          FormDynamicField(
            label: 'Title',
            hintText: 'Enter book title',
            initialValue: bookState.name,
            onChanged: notifier.updateName,
          ),
          const SizedBox(height: 20),

          // Author Field
          FormDynamicField(
            label: 'Author',
            hintText: 'Enter author name',
            initialValue: bookState.author,
            onChanged: notifier.updateAuthor,
          ),
          const SizedBox(height: 20),

          // Total Pages Field
          FormDynamicField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateTotalPages(pages);
            },
          ),
          const SizedBox(height: 20),

          // Color Selector Widget
          FormColorSelector(
            selectedColor: bookState.color,
            onColorSelected: notifier.updateColor,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
