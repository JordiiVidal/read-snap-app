import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormBody extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final String bookId;

  const SessionFormBody(this.formKey, this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));
    final notifier = ref.read(sessionFormNotifierProvider.notifier);

    if (bookAsync.isLoading || bookAsync.hasError) {
      return Center(
        child: bookAsync.hasError
            ? Text('Error loading book details')
            : const CircularProgressIndicator(),
      );
    }

    final book = bookAsync.value!;
    final startPageInitialValue = (book.currentPage ?? 0).toString();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Start Page Field
          FormDynamicField(
            label: 'Start Page',
            hintText: 'Enter start page',
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: startPageInitialValue),
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateStartPage(pages);
            },
          ),
          const SizedBox(height: 20),

          // End Page Field
          FormDynamicField(
            label: 'End Page',
            hintText: 'Enter end page',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final pages = int.tryParse(value) ?? 0;
              notifier.updateEndPage(pages);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
