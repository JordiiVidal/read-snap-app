import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final Widget header;
  final List<Widget> children;
  final Widget footer;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double height;
  final double width;

  const StatCard({
    required this.header,
    required this.children,
    required this.footer,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.height = 180.0,
    this.width = 160.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white30,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w400,
                ),
                child: header,
              ),

              // Body
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),

              // Footer
              DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
                child: footer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
