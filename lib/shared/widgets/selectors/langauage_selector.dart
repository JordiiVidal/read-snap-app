import 'package:flutter/material.dart';

class LanguageOption {
  final String code;
  final String label;
  final String flag;

  const LanguageOption({
    required this.code,
    required this.label,
    required this.flag,
  });
}

class LangauageSelector extends StatelessWidget {
  final String? selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  static const List<LanguageOption> languages = [
    LanguageOption(code: 'en', label: 'English', flag: '🇺🇸'),
    LanguageOption(code: 'es', label: 'Spanish', flag: '🇪🇸'),
    LanguageOption(code: 'ca', label: 'Catalan', flag: '🇪🇸'),
    LanguageOption(code: 'eu', label: 'Basque', flag: '🇪🇸'),
    LanguageOption(code: 'gl', label: 'Galician', flag: '🇪🇸'),
    LanguageOption(code: 'nl', label: 'Dutch', flag: '🇳🇱'),
    LanguageOption(code: 'da', label: 'Danish', flag: '🇩🇰'),
    LanguageOption(code: 'fi', label: 'Finnish', flag: '🇫🇮'),
    LanguageOption(code: 'sv', label: 'Swedish', flag: '🇸🇪'),
    LanguageOption(code: 'no', label: 'Norwegian', flag: '🇳🇴'),
    LanguageOption(code: 'fr', label: 'French', flag: '🇫🇷'),
    LanguageOption(code: 'de', label: 'German', flag: '🇩🇪'),
    LanguageOption(code: 'it', label: 'Italian', flag: '🇮🇹'),
    LanguageOption(code: 'pt', label: 'Portuguese', flag: '🇵🇹'),
    LanguageOption(code: 'ru', label: 'Russian', flag: '🇷🇺'),
    LanguageOption(code: 'zh', label: 'Chinese', flag: '🇨🇳'),
  ];

  const LangauageSelector(
    this.onLanguageChanged, {
    this.selectedLanguage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final lang = languages[index];
          return _LanguageChip(
            option: lang,
            selected: selectedLanguage == lang.code,
            onTap: () => onLanguageChanged(lang.code),
          );
        },
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final LanguageOption option;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageChip({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(option.flag, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            option.label,
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
