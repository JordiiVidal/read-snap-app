import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/presentation/presentation.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionFormPage extends ConsumerStatefulWidget {
  final String bookId;

  const SessionFormPage(this.bookId, {super.key});

  @override
  ConsumerState<SessionFormPage> createState() => _SessionFormPageState();
}

class _SessionFormPageState extends ConsumerState<SessionFormPage> {
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit(
    SessionFormNotifier notifier,
    ScaffoldMessengerState messenger,
    String bookId,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await notifier.saveSession();

      final bookDetailNotifier = ref.read(
        bookDetailNotifierProvider(widget.bookId).notifier,
      );
      final sessionListNotifier = ref.read(
        sessionListNotifierProvider(widget.bookId).notifier,
      );
      // Stats
      ref.invalidate(totalTimeProvider(widget.bookId));

      await bookDetailNotifier.loadBook();
      await sessionListNotifier.loadSessions();

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${e is ArgumentError ? e.message : 'Could not save book'}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(sessionFormNotifierProvider(widget.bookId));
    final notifier = ref.read(
      sessionFormNotifierProvider(widget.bookId).notifier,
    );
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final isLoading = formState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Record Reading Session',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: formState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildErrorState(e),
        data: (sessionEntity) => Padding(
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
              Expanded(
                child: SessionFormBody(_formKey, sessionEntity, notifier),
              ),

              // Submit Button
              const SizedBox(height: 20),
              SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  child: FormSubmit(
                    isLoading: isLoading,
                    'Record Session',
                    () => _handleSubmit(
                      notifier,
                      scaffoldMessenger,
                      widget.bookId,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(Object e) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Failed to load initial book data.'),
          const SizedBox(height: 8),
          Text(e.toString()),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
