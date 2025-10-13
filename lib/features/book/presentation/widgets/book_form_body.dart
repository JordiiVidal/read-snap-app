import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';

class BookFormBody extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const BookFormBody(this.formKey, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookState = ref.watch(bookFormNotifierProvider);
    final notifier = ref.read(bookFormNotifierProvider.notifier);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'Add a book to your reading tracker. Fill in the details below.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 20),

          // Title Field
          FormDynamicField(
            label: 'Title',
            hintText: 'Enter book title',
            onChanged: notifier.updateName,
          ),
          const SizedBox(height: 20),

          // Author Field
          FormDynamicField(
            label: 'Author',
            hintText: 'Enter author name',
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

          // Status Dropdown Field
          const Text(
            'Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<BookStatus>(
            initialValue: bookState.status,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: BookStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (BookStatus? newStatus) {
              if (newStatus != null) {
                notifier.updateStatus(newStatus);
              }
            },
          ),

          // Current Page Field (if reading)
          if (bookState.status == BookStatus.reading)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FormDynamicField(
                label: 'Current Page',
                hintText: '0',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final pages = int.tryParse(value) ?? 0;
                  notifier.updateCurrentPage(pages);
                },
              ),
            ),
          const SizedBox(height: 20),

          // Color Selector Widget
          FormColorSelector(
            selectedColor: bookState.color,
            onColorSelected: notifier.updateColor,
          ),
        ],
      ),
    );
  }
}
