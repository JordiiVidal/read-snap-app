import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDataSelector<T> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T>> provider;
  final Widget Function(BuildContext context, T data) builder;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, Object error, StackTrace? stack)?
  errorBuilder;
  final Widget? emptyWidget;

  const AsyncDataSelector({
    super.key,
    required this.provider,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(provider);

    return asyncData.when(
      data: (data) {
        if (data == null && emptyWidget != null) {
          return emptyWidget!;
        }
        return builder(context, data);
      },
      loading: () => loadingWidget ?? _defaultLoadingWidget(),
      error: (error, stack) => errorBuilder != null
          ? errorBuilder!(context, error, stack)
          : _defaultErrorWidget(context, error),
    );
  }

  Widget _defaultLoadingWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _defaultErrorWidget(BuildContext context, Object error) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Error: ${error.toString()}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
