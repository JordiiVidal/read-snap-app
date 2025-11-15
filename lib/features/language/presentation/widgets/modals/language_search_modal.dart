import 'package:flutter/material.dart';
import 'package:read_snap/features/language/domain/domain.dart';
import 'package:read_snap/shared/widgets/forms/dynamic_form_field.dart';

class LanguageSearchModal extends StatefulWidget {
  final List<LanguageEntity> languages;

  const LanguageSearchModal(this.languages, {super.key});

  static Future<String?> show(
    BuildContext context,
    List<LanguageEntity> languages,
  ) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => LanguageSearchModal(languages),
    );
  }

  @override
  State<LanguageSearchModal> createState() => _LanguageSearchModalState();
}

class _LanguageSearchModalState extends State<LanguageSearchModal> {
  static const double _fieldSpacing = 20.0;
  static const double _maxHeight = 700.0;

  late final TextEditingController _searchController;
  late List<LanguageEntity> _filteredLanguages;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredLanguages = widget.languages;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: _maxHeight),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: _fieldSpacing,
            children: [
              // Handle indicator
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Search field
              DynamicFormField(
                label: 'Search',
                controller: _searchController,
                hintText: 'Search for a language',
                prefixIcon: const Icon(Icons.search),
                onChanged: _handleSearch,
              ),

              // Filtered languages list
              Expanded(child: _buildLanguageList()),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLanguages = widget.languages;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredLanguages = widget.languages.where((language) {
          return language.name.toLowerCase().contains(lowerQuery) ||
              language.nativeName.toLowerCase().contains(lowerQuery) ||
              language.code.toLowerCase().contains(lowerQuery);
        }).toList();
      }
    });
  }

  Widget _buildLanguageList() {
    if (_filteredLanguages.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredLanguages.length,
      itemBuilder: (context, index) {
        final language = _filteredLanguages[index];
        return ListTile(
          leading: Text(language.flag, style: const TextStyle(fontSize: 24)),
          title: Text(language.name),
          subtitle: Text(language.nativeName),
          trailing: Text(
            language.code.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => Navigator.of(context).pop(language.code),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No languages found',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
