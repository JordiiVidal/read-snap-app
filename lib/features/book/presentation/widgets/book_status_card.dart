import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:read_snap/common/widgets/widgets.dart';
import 'package:read_snap/features/book/domain/domain.dart';

class BookStatusCard extends StatelessWidget {
  final BookEntity book;

  const BookStatusCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final dateToFormat = book.createdAt;
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final formattedDate = dateFormatter.format(dateToFormat);

    return CustomCard(
      header: const Text('Status'),
      footer: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Started'),
          Text(
            formattedDate,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      children: [
        Text(
          book.status.name.toUpperCase(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
