import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';

enum BookListItemVariant { card, listTile }

class BookListItem extends StatelessWidget {
  final BookEntity book;
  final BookListItemVariant variant;
  final VoidCallback? onTap;

  const BookListItem({
    super.key,
    required this.book,
    this.variant = BookListItemVariant.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      BookListItemVariant.card => _buildCard(context),
      BookListItemVariant.listTile => _buildListTile(context),
    };
  }

  // ========== Card Variant (Horizontal) ==========
  Widget _buildCard(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage =
        book.imageThumbnail != null && book.imageThumbnail!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 220,
        height: 280, // Altura fija para mantener consistencia
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Background: Imagen o Color
              if (hasImage)
                Positioned.fill(
                  child: Image.network(
                    book.imageThumbnail!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.8),
                              Colors.black.withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                ),

              // Gradient Overlay para legibilidad del texto
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3), // Más claro arriba
                        Colors.black.withValues(alpha: 0.7), // Más oscuro abajo
                      ],
                    ),
                  ),
                ),
              ),

              // Contenido
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Title - Siempre visible
                    Text(
                      book.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.8),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Author - Siempre visible
                    Text(
                      book.author,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.8),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Progress Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${book.progressPercentage}%',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${book.currentPage}/${book.totalPages}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Progress Bar
                    LinearProgressIndicator(
                      value: book.progressValue,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== ListTile Variant (Vertical) ==========
  Widget _buildListTile(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(
          book.imageThumbnail!,
          fit: BoxFit.cover,
          width: 40,
          height: 60,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 40);
          },
        ),
      ),
      title: Text(
        book.title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        book.author,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontStyle: FontStyle.italic,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
