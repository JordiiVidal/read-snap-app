import 'package:flutter/material.dart';
import 'package:read_snap/features/book/presentation/widgets/steps/book_step_details.dart';
import 'package:read_snap/features/book/presentation/widgets/steps/book_step_preview.dart';
import 'package:read_snap/features/book/presentation/widgets/steps/book_step_search.dart';
import 'package:read_snap/features/book/presentation/widgets/steps/book_step_status.dart';
import 'package:read_snap/shared/widgets/wizard/wizard.dart';

class BookCreateWizard extends StatefulWidget {
  final Function() onSubmit;

  const BookCreateWizard(this.onSubmit, {super.key});

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

  void _submit() {
    widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          HeaderWizard(
            currentStep: _currentStep,
            totalSteps: 4,
            onBack: _previousStep,
          ),
          BodyWizard(
            child: switch (_currentStep) {
              0 => BookStepSearch(onNext: _nextStep),
              1 => BookStepStatus(onNext: _nextStep, onBack: _previousStep),
              2 => BookStepDetails(onNext: _nextStep, onBack: _previousStep),
              3 => BookStepPreview(onSubmit: _submit, onBack: _previousStep),
              _ => throw UnimplementedError(),
            },
          ),
        ],
      ),
    );
  }
}
