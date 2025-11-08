import 'package:flutter/material.dart';

class LoadingLine extends StatelessWidget {
  final double width;
  final double height;

  const LoadingLine({
    this.width = double.infinity,
    this.height = 16.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
