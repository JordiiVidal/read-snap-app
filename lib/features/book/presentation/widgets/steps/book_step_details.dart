import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/domain/domain.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/book/presentation/widgets/selectors/book_type_selector.dart';
import 'package:read_snap/features/category/presentation/widgets/selectors/category_selector.dart';
import 'package:read_snap/features/language/presentation/widgets/selectors/language_selector.dart';
import 'package:read_snap/shared/utils/custom_snack_bar.dart';
import 'package:read_snap/shared/widgets/steps/steps.dart';

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
    final book = ref.watch(bookCreateNotifierProvider).value!;
    final bookNotifier = ref.read(bookCreateNotifierProvider.notifier);

    return Column(
      children: [
        // Header
        const HeaderStep(
          title: 'Details',
          subtitle: 'Select the language and categories for this book',
        ),

        // Form
        ContentStep.scrollable(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _sectionSpacing,
            children: [
              // Language Selector
              LanguageSelector(
                selectedLanguage: book.language,
                onLanguageChanged: (language) {
                  _dismissKeyboard();
                  bookNotifier.updateLanguage(language);
                },
              ),

              // Categories Selector
              CategorySelector(
                selectedCategories: book.categories,
                onCategoriesChanged: (categories) {
                  _dismissKeyboard();
                  bookNotifier.updateCategories(categories);
                },
              ),

              // Book Type Selector
              BookTypeSelector(
                selectedType: book.type,
                onTypeChanged: (type) {
                  _dismissKeyboard();
                  bookNotifier.updateType(type);
                },
              ),
            ],
          ),
        ),

        // Footer
        FooterStep(onAction: _handleNext, label: 'Next'),
      ],
    );
  }

  void _handleNext() {
    final book = ref.read(bookCreateNotifierProvider).value!;
    final error = BookDetailsValidatorService.validateBookDetails(book);

    if (error != null) {
      CustomSnackBar.showError(context, error);
      return;
    }

    widget.onNext();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
