import 'package:flutter/material.dart';
import 'package:read_snap/features/book/presentation/widgets/create/steps/book_step_details.dart';
import 'package:read_snap/features/book/presentation/widgets/create/steps/book_step_preview.dart';
import 'package:read_snap/features/book/presentation/widgets/create/steps/book_step_search.dart';
import 'package:read_snap/features/book/presentation/widgets/create/steps/book_step_status.dart';

class BookCreateWizard extends StatefulWidget {
  const BookCreateWizard({super.key});

  @override
  State<BookCreateWizard> createState() => _BookCreateWizardState();
}

class _BookCreateWizardState extends State<BookCreateWizard> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          LinearProgressIndicator(value: _currentStep / 4),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: switch (_currentStep) {
                        0 => BookStepSearch(onNext: _nextStep),
                        1 => BookStepStatus(
                          onNext: _nextStep,
                          onBack: _previousStep,
                        ),
                        2 => BookStepDetails(
                          onNext: _nextStep,
                          onBack: _previousStep,
                        ),
                        3 => BookStepPreview(
                          onSubmit: _nextStep,
                          onBack: _previousStep,
                        ),
                        _ => throw UnimplementedError(),
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
