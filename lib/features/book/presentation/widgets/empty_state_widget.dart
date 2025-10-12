import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const EmptyStateWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 64, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'No books yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Start tracking your reading by adding your first book',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: onPressed, child: const Text('Add Book')),
          ],
        ),
      ),
    );
  }
}
