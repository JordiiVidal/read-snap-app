import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/category/presentation/widgets/selectors/category_selector.dart';
import 'package:read_snap/features/language/presentation/widgets/selectors/language_selector.dart';
import 'package:read_snap/shared/widgets/wizard/wizard.dart';

class BookStepDetails extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const BookStepDetails({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  ConsumerState<BookStepDetails> createState() => _BookStepDetailsState();
}

class _BookStepDetailsState extends ConsumerState<BookStepDetails> {
  static const double _sectionSpacing = 24.0;

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookCreateNotifierProvider).value!;
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _sectionSpacing,
      children: [
        // Header
        const StepHeaderWizard(
          title: 'Details',
          subtitle: 'Select the language and categories for this book',
        ),

        // Language Selector
        LanguageSelector(
          selectedLanguage: bookState.language,
          onLanguageChanged: (language) {
            _dismissKeyboard();
            bookCreateNotifier.updateLanguage(language);
          },
        ),

        // Categories Selector
        CategorySelector(
          selectedCategories: bookState.categories,
          onCategoriesChanged: (categories) {
            _dismissKeyboard();
            bookCreateNotifier.updateCategories(categories);
          },
        ),

        const Spacer(),

        // Next Button
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _handleNext,
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }

  void _handleNext() {
    final bookState = ref.read(bookCreateNotifierProvider).value!;
    final error = BookDetailsValidatorService.validateBookDetails(bookState);

    if (error != null) {
      _showErrorSnackBar(error);
      return;
    }

    widget.onNext();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
