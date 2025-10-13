import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/common/widgets/info_card.dart';
import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_detail_notifier.dart';
import 'package:read_snap/features/book/presentation/notifiers/book_list_notifier.dart';

class BookDetailPage extends ConsumerWidget {
  final String bookId;

  const BookDetailPage(this.bookId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ⭐️ Observamos el estado del libro (AsyncValue<BookEntity>)
    final bookAsync = ref.watch(bookDetailNotifierProvider(bookId));
    final notifier = ref.read(bookDetailNotifierProvider(bookId).notifier);

    return bookAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('Error loading book: $e')),
      ),
      data: (book) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // Usa el color del libro como fondo si está disponible
            backgroundColor: Color(
              int.parse(book.color.replaceFirst('#', '0xFF')),
            ).withValues(alpha: 0.9),
            foregroundColor: Colors.white,
            title: const Text('Back to Library'), // Como en tu diseño
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Navegar a la página de edición.
                },
              ),
            ],
            // Usamos PreferredSize para poner el encabezado de detalle justo debajo del AppBar
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: _BookHeader(book: book),
            ),
          ),
          body: _BookDetailBody(book: book, notifier: notifier, ref: ref),
        ),
      ),
    );
  }
}

// -----------------------------------------------------
// WIDGETS AUXILIARES
// -----------------------------------------------------

class _BookHeader extends StatelessWidget {
  final BookEntity book;

  const _BookHeader({required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icono/Inicial del libro
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                book.name.isNotEmpty ? book.name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Título y Autor
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  book.author,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookDetailBody extends StatelessWidget {
  final BookEntity book;
  final BookDetailNotifier notifier;
  final WidgetRef ref; // Necesitamos el ref para la acción de eliminar

  const _BookDetailBody({
    required this.book,
    required this.notifier,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Botones de Sesión y Eliminar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActionButton(
                icon: Icons.access_time,
                label: 'Record Session',
                onPressed: () {
                  // TODO: Implementar iniciar sesión
                },
              ),
              _ActionButton(
                icon: Icons.delete_outline,
                label: 'Delete Book',
                color: Colors.red,
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
        ),

        // Cards Informativas
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Progress Card
              InfoCard(
                title: 'Progress',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${((book.currentPage ?? 0) / book.totalPages * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: (book.currentPage ?? 0) / book.totalPages,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(int.parse(book.color.replaceFirst('#', '0xFF'))),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${book.currentPage ?? 0} / ${book.totalPages} pages',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Reading Time Card (Visual)
              const InfoCard(
                title: 'Reading Time',
                content: Text(
                  '0 minutes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // Status Card
              InfoCard(
                title: 'Status',
                content: Text(
                  book.status.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Pestañas (Tabs)
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: TabBar(
            tabs: [
              Tab(text: 'Notes (0)'),
              Tab(text: 'Sessions (0)'),
            ],
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
        ),
        // Contenido de las Pestañas (Visualmente vacío por ahora)
        Expanded(
          child: TabBarView(
            children: [
              const Center(child: Text('No notes yet')), // Contenido Notes
              const Center(
                child: Text('No sessions yet'),
              ), // Contenido Sessions
            ],
          ),
        ),
      ],
    );
  }

  // Lógica de eliminación (Side Effect)
  Future<void> _confirmDelete(BuildContext context) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text(
          'Are you sure you want to delete this book? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await notifier.deleteBook();
      // Refrescar la lista en la página anterior y navegar hacia atrás
      await ref.read(bookListNotifierProvider.notifier).refreshBooks();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}

// Widget auxiliar para los botones de acción (Session / Delete)
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
