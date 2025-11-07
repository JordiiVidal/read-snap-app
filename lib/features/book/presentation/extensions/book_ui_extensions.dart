import 'package:flutter/material.dart';
import 'package:read_snap/features/book/domain/domain.dart';

extension BookColorUIExtension on BookEntity {
  Color get flutterColor {
    final hexCode = color.replaceFirst('#', '0xFF');
    final intColor = int.tryParse(hexCode);
    if (intColor == null) return Colors.grey;
    return Color(intColor);
  }
}
