import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_form_notifier.dart';
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
    // 1. Observar el estado de la Entidad actual del formulario
    final bookState = ref.watch(bookFormNotifierProvider);
    final notifier = ref.read(bookFormNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Book')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
              DynamicFormField(
                label: 'Current Page',
                hintText: '0', // No lo usamos, pero lo dejamos de guía
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final pages = int.tryParse(value) ?? 0;
                  notifier.updateCurrentPage(pages);
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
              const SizedBox(height: 20),
              ColorSelectorWidget(
                selectedColor: bookState.color,
                onColorSelected: notifier.updateColor,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () async {},
                    child: const Text('Add Book'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
