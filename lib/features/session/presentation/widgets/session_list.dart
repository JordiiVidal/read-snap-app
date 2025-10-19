import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionList extends ConsumerWidget {
  final String bookId;
  final void Function()? createAction;

  const SessionList(this.bookId, {super.key, this.createAction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionListNotifierProvider(bookId));

    return sessionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading sessions: $e')),
      data: (sessions) {
        if (sessions.isEmpty) {
          return Center(
            child: EmptyState(
              title: 'No sessions yet',
              message:
                  'Start tracking your reading by adding your first session',
              buttonText: 'Add Session',
              onPressed: createAction,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return SessionListItem(session);
          },
        );
      },
    );
  }
}
