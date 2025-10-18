import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text(
              'Track your reading time and pages read.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            SessionFormBody(_formKey, widget.bookId),
          ],
        ),
      ),
    );
  }
}
