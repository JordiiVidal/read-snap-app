import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_create_notifier.dart';
import 'package:read_snap/features/category/presentation/widgets/category_selector.dart';
import 'package:read_snap/features/language/presentation/widgets/language_selector.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookCreateNotifierProvider).value!;
    final bookCreateNotifier = ref.read(bookCreateNotifierProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        children: [
          Text('Details'),
          Text('Provide the reading status and some additional information'),

          // Language Selector
          LabelFormField('Language', marginBottom: 0),
          LanguageSelector(
            selectedLanguage: bookState.language,
            onLanguageChanged: (language) {
              FocusScope.of(context).unfocus();
              bookCreateNotifier.updateLanguage(language);
            },
          ),

          // Categories Selector
          CategorySelector(
            selectedCategories: bookState.categories,
            onCategoriesChanged: (categories) {
              FocusScope.of(context).unfocus();
              bookCreateNotifier.updateCategories(categories);
            },
          ),

          Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: widget.onNext, child: Text('Next')),
          ),
        ],
      ),
    );
  }
}
