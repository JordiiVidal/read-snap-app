import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String header;
  final String title;
  final Widget content;
  final String footer;

  const InfoCard({
    required this.header,
    required this.title,
    required this.content,
    required this.footer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 220,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              content,
              Text(
                footer,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
