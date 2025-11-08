import 'package:flutter/material.dart';

class PageFormScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget form;
  final VoidCallback onSubmit;
  final String submitButtonText;
  final bool isLoading;
  final bool showLoadingOverlay;

  const PageFormScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.form,
    required this.onSubmit,
    required this.submitButtonText,
    this.isLoading = false,
    this.showLoadingOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: ListView(
              children: [
                // Title
                Text(
                  title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  subtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),

                // Form (injected)
                form,
                const SizedBox(height: 30),

                // Submit Button
                SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: isLoading ? null : onSubmit,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(submitButtonText),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading Overlay (opcional)
          if (showLoadingOverlay && isLoading) ...[
            const ModalBarrier(color: Colors.black12, dismissible: false),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
