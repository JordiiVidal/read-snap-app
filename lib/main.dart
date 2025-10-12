import 'package:flutter/material.dart';
import 'package:read_snap/core/injection_container.dart';
import 'package:read_snap/features/book/presentation/pages/book_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: ReadSnapApp()));
}

class ReadSnapApp extends ConsumerWidget {
  const ReadSnapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ReadSnap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
      ),
      home: ref
          .watch(databaseProvider)
          .when(
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Fatal Error: Could not initialize database.',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text('$err'),
                  ],
                ),
              ),
            ),
            data: (_) => const BookListPage(),
          ),
    );
  }
}
