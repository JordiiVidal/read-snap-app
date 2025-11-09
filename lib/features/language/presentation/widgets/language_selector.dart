import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/language/domain/domain.dart';
import 'package:read_snap/features/language/presentation/notifiers/language_list_notifier.dart';

class LanguageSelector extends ConsumerWidget {
  final String? selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languagesAsync = ref.watch(languageListNotifierProvider);

    return languagesAsync.when(
      data: (languages) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: languages.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final lang = languages[index];
              return _LanguageChip(
                language: lang,
                selected: selectedLanguage == lang.code,
                onTap: () => onLanguageChanged(lang.code),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: SizedBox(height: 40, child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Text('Error loading languages: $error'),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final LanguageEntity language;
  final bool selected;
  final VoidCallback onTap;

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
          Text(language.flag, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            language.name,
            style: TextStyle(
              fontSize: 12,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
