import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/language/domain/domain.dart';
import 'package:read_snap/features/language/presentation/notifiers/language_list_notifier.dart';
import 'package:read_snap/features/language/presentation/widgets/modals/language_search_modal.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';
import 'package:read_snap/shared/widgets/selectors/selectors.dart';

class LanguageSelector extends ConsumerWidget {
  final String? selectedLanguage;
  final ValueChanged<String> onLanguageChanged;
  final String? label;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
    this.label = 'Language',
  });

  static const double _chipHeight = 40.0;
  static const double _chipSpacing = 8.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelFormField(label ?? 'Language', marginBottom: 0),
            TextButton.icon(
              icon: const Icon(Icons.search, size: 18),
              label: const Text('Search'),
              onPressed: () => _showLanguageSearchModal(context, ref),
            ),
          ],
        ),

        // Language List
        AsyncDataSelector<List<LanguageEntity>>(
          provider: languageListNotifierProvider,
          loadingWidget: const Center(
            child: SizedBox(
              height: _chipHeight,
              child: CircularProgressIndicator(),
            ),
          ),
          builder: (context, languages) {
            return SizedBox(
              height: _chipHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: languages.length,
                separatorBuilder: (_, _) => const SizedBox(width: _chipSpacing),
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return _LanguageChip(
                    language: language,
                    selected: selectedLanguage == language.code,
                    onTap: () => onLanguageChanged(language.code),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _showLanguageSearchModal(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // Get languages from provider
    final languagesAsync = ref.read(languageListNotifierProvider);

    // Check if data is available
    final languages = languagesAsync.valueOrNull;
    if (languages == null) {
      _showErrorSnackBar(context, 'Languages not loaded yet');
      return;
    }

    // Show modal
    final result = await LanguageSearchModal.show(context, languages);

    // Check if widget is still mounted after async operation
    if (!context.mounted) return;

    // Update selection if user chose a language
    if (result != null) {
      onLanguageChanged(result);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final LanguageEntity language;
  final bool selected;
  final VoidCallback onTap;

  static const double _spacing = 8.0;

  const _LanguageChip({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(language.flag),
          const SizedBox(width: _spacing),
          Text(language.name),
        ],
      ),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
