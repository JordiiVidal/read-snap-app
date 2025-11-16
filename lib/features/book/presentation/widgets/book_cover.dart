import 'package:flutter/material.dart';

class BookCover extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final double? placeholderIconSize;

  const BookCover({
    super.key,
    this.imageUrl,
    this.width = 80,
    this.height = 120,
    this.borderRadius = 8,
    this.placeholderIconSize,
  });

  const BookCover.small({super.key, this.imageUrl})
    : width = 60,
      height = 90,
      borderRadius = 8,
      placeholderIconSize = 32;

  const BookCover.medium({super.key, this.imageUrl})
    : width = 80,
      height = 120,
      borderRadius = 8,
      placeholderIconSize = 40;

  const BookCover.large({super.key, this.imageUrl})
    : width = 120,
      height = 180,
      borderRadius = 12,
      placeholderIconSize = 60;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildLoading();
              },
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.book_rounded,
        size: placeholderIconSize ?? (width * 0.5),
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: CircularProgressIndicator(strokeWidth: width > 80 ? 3 : 2),
      ),
    );
  }
}
