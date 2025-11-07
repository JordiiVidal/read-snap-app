import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';
import 'package:read_snap/shared/widgets/common/form_page_scaffold.dart';

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
    final sessionAsync = ref.watch(
      sessionCreateNotifierProvider(widget.bookId),
    );
    final sessionNotifier = ref.read(
      sessionCreateNotifierProvider(widget.bookId).notifier,
    );
    final isLoading = sessionAsync.isLoading;

    return FormPageScaffold(
      title: 'Record Reading Session',
      subtitle: 'Track your reading time and pages read.',
      isLoading: isLoading,
      submitButtonText: 'Record Session',
      showLoadingOverlay: true, // Session usa overlay
      form: SessionForm(_formKey, widget.bookId),
      onSubmit: () => _handleSubmit(sessionNotifier),
    );
  }

  Future<void> _handleSubmit(SessionCreateNotifier notifier) async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await notifier.saveSession();
      if (mounted) Navigator.of(context).pop();
    } on ArgumentError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Could not save session')),
        );
      }
    }
  }
}
