import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookCreateForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const BookCreateForm(this.formKey, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookCreateAsync = ref.watch(bookCreateNotifierProvider);
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);
    final BookEntity bookState = bookCreateAsync.value!;

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
              bookCreateNotifier.updateStatus(status);
            },
          ),

          // Title Field
          FormDynamicField(
            label: 'Title',
            hintText: 'Enter book title',
            required: true,
            initialValue: bookState.name,
            onChanged: bookCreateNotifier.updateName,
          ),

          // Author Field
          FormDynamicField(
            label: 'Author',
            hintText: 'Enter author name',
            required: true,
            initialValue: bookState.author,
            onChanged: bookCreateNotifier.updateAuthor,
          ),

          // Total Pages Field
          FormDynamicField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            required: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              bookCreateNotifier.updateTotalPages(pages);
            },
          ),
        ],
      ),
    );
  }
}
