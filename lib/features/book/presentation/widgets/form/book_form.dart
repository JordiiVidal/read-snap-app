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
    final bookFormAsync = ref.watch(bookFormNotifierProvider);
    final bookFormNotifier = ref.read(bookFormNotifierProvider.notifier);
    final BookEntity bookState = bookFormAsync.value!;

    return Form(
      key: formKey,
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Select Button Group
          SelectButtonGroup(
            label: 'Status',
            required: true,
            options: {
              BookStatus.reading.name: 'Reading',
              BookStatus.completed.name: 'Completed',
              BookStatus.toRead.name: 'To Read',
            },
            selectedValues: [bookState.status.name],
            onSelectionChanged: (values) {
              final statusName = values.first;
              final status = BookStatus.values.byName(statusName);
              bookFormNotifier.updateStatus(status);
            },
          ),

          // Title Field
          FormDynamicField(
            label: 'Title',
            hintText: 'Enter book title',
            required: true,
            initialValue: bookState.name,
            onChanged: bookFormNotifier.updateName,
          ),

          // Author Field
          FormDynamicField(
            label: 'Author',
            hintText: 'Enter author name',
            required: true,
            initialValue: bookState.author,
            onChanged: bookFormNotifier.updateAuthor,
          ),

          // Total Pages Field
          FormDynamicField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            required: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              bookFormNotifier.updateTotalPages(pages);
            },
          ),
        ],
      ),
    );
  }
}
