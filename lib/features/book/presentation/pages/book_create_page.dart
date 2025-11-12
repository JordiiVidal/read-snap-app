import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/widgets/create/book_create_wizard.dart';

class BookCreatePage extends ConsumerStatefulWidget {
  const BookCreatePage({super.key});

  @override
  ConsumerState<BookCreatePage> createState() => _BookCreatePageState();
}

class _BookCreatePageState extends ConsumerState<BookCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BookCreateWizard()));
  }
}
