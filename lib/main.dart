import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/config/app_theme.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/book/presentation/pages/book_list_page.dart';

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
      theme: AppTheme.lightTheme,
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
