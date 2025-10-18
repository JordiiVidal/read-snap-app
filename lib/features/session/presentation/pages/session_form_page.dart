import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormPage extends ConsumerStatefulWidget {
  final String bookId;
  const SessionFormPage(this.bookId, {super.key});

  @override
  ConsumerState<SessionFormPage> createState() => _SessionFormPageState();
}

class _SessionFormPageState extends ConsumerState<SessionFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(sessionFormNotifierProvider.notifier);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    void close() => Navigator.of(context).pop();

    void handleSubmit(
      SessionFormNotifier notifier,
      ScaffoldMessengerState scaffoldMessenger,
    ) async {
      if (_formKey.currentState!.validate()) {
        try {
          await notifier.saveSession();
          await ref
              .read(sessionListNotifierProvider.notifier)
              .refreshSessions();
          if (!mounted) return;
          close();
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
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Record Reading Session',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [IconButton(icon: const Icon(Icons.close), onPressed: close)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Description
            Text(
              'Track your reading time and pages read.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Form Body
            SessionFormBody(_formKey, widget.bookId),

            // Submit Button
            const SizedBox(height: 20),
            SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: FormSubmit(
                  'Record Session',
                  () => handleSubmit(notifier, scaffoldMessenger),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
