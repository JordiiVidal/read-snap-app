import 'package:flutter/material.dart';
import 'package:read_snap/features/category/domain/domain.dart';
import 'package:read_snap/shared/widgets/fields/dynamic_form_field.dart';

class CategoryCreateModal extends StatefulWidget {
  final List<CategoryEntity> categories;

  const CategoryCreateModal(this.categories, {super.key});

  static Future<String?> show(
    BuildContext context,
    List<CategoryEntity> categories,
  ) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => CategoryCreateModal(categories),
    );
  }

  @override
  State<CategoryCreateModal> createState() => _CategoryCreateModalState();
}

class _CategoryCreateModalState extends State<CategoryCreateModal> {
  static const double _fieldSpacing = 20.0;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: _fieldSpacing,
              children: [
                // Header
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Category Name Field
                DynamicFormField(
                  hintText: 'Enter category name',
                  label: 'Category Name',
                  required: true,
                  controller: _textController,
                  validator: (value) =>
                      CategoryValidatorService.validateCategoryName(
                        value!,
                        widget.categories,
                      ),
                ),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _handleSubmit,
                    child: Text('Create Category'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    final name = _textController.text.trim();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    Navigator.of(context).pop(name);
  }
}
