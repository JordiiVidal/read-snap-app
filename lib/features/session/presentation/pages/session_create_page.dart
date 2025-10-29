import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionCreatePage extends ConsumerStatefulWidget {
  final String bookId;

  const SessionCreatePage(this.bookId, {super.key});

  @override
  ConsumerState<SessionCreatePage> createState() => _SessionCreatePageState();
}

class _SessionCreatePageState extends ConsumerState<SessionCreatePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sessionCreateAsync = ref.watch(
      sessionCreateNotifierProvider(widget.bookId),
    );
    final sessionCreateNotifier = ref.read(
      sessionCreateNotifierProvider(widget.bookId).notifier,
    );
    final isLoading = sessionCreateAsync.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Record Reading Session',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Descripiton
                const Text(
                  'Track your reading time and pages read.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 20),

                // Form Body
                Expanded(child: SessionForm(_formKey, widget.bookId)),

                // Submit Button
                const SizedBox(height: 20),
                SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: FormSubmit(
                      isLoading: isLoading,
                      'Record Session',
                      () => _handleSubmit(sessionCreateNotifier),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading) ...[
            const ModalBarrier(color: Colors.black12, dismissible: false),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }

  void _handleSubmit(SessionCreateNotifier notifier) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await notifier.saveSession();

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${e is ArgumentError ? e.message : 'Could not save session'}',
          ),
        ),
      );
    }
  }
}
