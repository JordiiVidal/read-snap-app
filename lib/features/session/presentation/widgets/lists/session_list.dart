import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/session/domain/entities/session_entity.dart';
import 'package:read_snap/features/session/presentation/notifiers/session_list_notifier.dart';
import 'package:read_snap/features/session/presentation/widgets/lists/session_list_item.dart';
import 'package:read_snap/shared/widgets/common/common.dart';

class SessionList extends ConsumerWidget {
  final String bookId;
  final VoidCallback? onEmptyActionTap;

  const SessionList({super.key, required this.bookId, this.onEmptyActionTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionListNotifierProvider(bookId));

    return sessionsAsync.when(
      loading: () => _buildLoading(),
      error: (error, stackTrace) => _buildError(context, error),
      data: (sessions) => sessions.isEmpty
          ? _buildEmpty(context)
          : _buildList(context, sessions),
    );
  }

  // ========== Loading State ==========
  Widget _buildLoading() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (_, index) =>
          _SessionListLoadingSkeleton(isFirst: index == 0, isLast: index == 2),
    );
  }

  // ========== Empty State ==========
  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: EmptyState(
        icon: Icons.access_time,
        title: 'No sessions yet',
        message: 'Start tracking your reading by adding your first session',
        actionLabel: 'Add Session',
        onActionPressed: onEmptyActionTap,
      ),
    );
  }

  // ========== Error State ==========
  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading sessions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ========== Data State ==========
  Widget _buildList(BuildContext context, List<SessionEntity> sessions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        return _SessionListItemWrapper(
          isFirst: index == 0,
          isLast: index == sessions.length - 1,
          child: SessionListItem(sessions[index]),
        );
      },
    );
  }
}

// ========== Item Wrapper (decoración de bordes) ==========
class _SessionListItemWrapper extends StatelessWidget {
  final Widget child;
  final bool isFirst;
  final bool isLast;

  const _SessionListItemWrapper({
    required this.child,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(16) : Radius.zero,
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: child,
    );
  }
}

// ========== Loading Skeleton ==========
class _SessionListLoadingSkeleton extends StatelessWidget {
  final bool isFirst;
  final bool isLast;

  const _SessionListLoadingSkeleton({
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return _SessionListItemWrapper(
      isFirst: isFirst,
      isLast: isLast,
      child: ListTile(
        title: Row(
          children: [
            Container(
              width: 80,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
