import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/session/presentation/presentation.dart';

class SessionList extends ConsumerWidget {
  final String bookId;
  final void Function()? createAction;

  const SessionList(this.bookId, {super.key, this.createAction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionListNotifierProvider(bookId));

    return sessionsAsync.when(
      loading: () => SessionListLoading(),
      error: (e, st) => Center(child: Text('Error loading sessions: $e')),
      data: (sessions) {
        if (sessions.isEmpty) {
          return SessionListEmpty();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              final isFirstItem = index == 0;
              final isLastItem = index == sessions.length - 1;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  borderRadius: BorderRadius.vertical(
                    top: isFirstItem
                        ? const Radius.circular(16.0)
                        : Radius.zero,
                    bottom: isLastItem
                        ? const Radius.circular(16.0)
                        : Radius.zero,
                  ),
                ),
                child: SessionListItem(session),
              );
            },
          ),
        );
      },
    );
  }
}
