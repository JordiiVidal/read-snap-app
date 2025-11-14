import 'package:flutter/material.dart';

class HeaderWizard extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onBack;

  const HeaderWizard({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 48,
          child: (currentStep > 0)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  constraints: const BoxConstraints(),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: Center(
            child: _StepIndicator(
              currentStep: currentStep,
              totalSteps: totalSteps,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _StepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return _StepDot(isActive: isActive, isCompleted: isCompleted);
      }),
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool isActive;
  final bool isCompleted;

  const _StepDot({required this.isActive, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive || isCompleted
            ? colorScheme.primary
            : colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
