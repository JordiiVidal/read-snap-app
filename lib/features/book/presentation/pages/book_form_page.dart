import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_form_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/color_selector_widget.dart';
import 'package:read_snap/features/book/presentation/widgets/dynamic_form_field_widget.dart';

class BookFormPage extends ConsumerStatefulWidget {
  const BookFormPage({super.key});

  @override
  ConsumerState<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends ConsumerState<BookFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookFormNotifierProvider);
    final notifier = ref.read(bookFormNotifierProvider.notifier);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: _form(notifier, bookState)),
            ),
            const SizedBox(height: 16),
            SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: _submit(notifier, navigator, scaffoldMessenger),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form _form(BookFormNotifier notifier, BookEntity bookState) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a book to your reading tracker. Fill in the details below.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          DynamicFormField(
            label: 'Title',
            hintText: 'Enter book title',
            onChanged: notifier.updateName,
          ),
          DynamicFormField(
            label: 'Author',
            hintText: 'Enter author name',
            onChanged: notifier.updateAuthor,
          ),
          DynamicFormField(
            label: 'Total Pages',
            hintText: 'Enter total pages',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateTotalPages(pages);
            },
          ),
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
          if (bookState.status == BookStatus.reading)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DynamicFormField(
                label: 'Current Page',
                hintText: '0',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final pages = int.tryParse(value) ?? 0;
                  notifier.updateCurrentPage(pages);
                },
              ),
            ),
          ColorSelectorWidget(
            selectedColor: bookState.color,
            onColorSelected: notifier.updateColor,
          ),
        ],
      ),
    );
  }

  ElevatedButton _submit(
    BookFormNotifier notifier,
    NavigatorState navigator,
    ScaffoldMessengerState scaffoldMessenger,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Ajusta el radio (ej: 8.0)
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            await notifier.saveBook();
            await ref.read(bookListNotifierProvider.notifier).refreshBooks();

            if (!mounted) return;
            navigator.pop();
          } catch (e) {
            if (!mounted) return;
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(
                  'Error: ${e is ArgumentError ? e.message : 'Could not save book'}',
                ),
              ),
            );
          }
        }
      },
      child: const Text('Add Book'),
    );
  }
}
