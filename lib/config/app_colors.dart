import 'package:flutter/material.dart';

Color _hexToColor(String hexCode) {
  return Color(int.parse(hexCode.replaceFirst('#', '0xFF')));
}

class AppColors {
  static final Color primary = _hexToColor('#3A7AFE');
  static final Color primaryVariant = _hexToColor('#2357D9');
  static final Color secondary = _hexToColor('#6C6F93');
  static final Color success = _hexToColor('#22C55E');
  static final Color warning = _hexToColor('#FACC15');
  static final Color error = _hexToColor('#EF4444');

  static final Color background = _hexToColor('#F8FAFC');
  static final Color surface = _hexToColor('#FFFFFF');

  static final Color textPrimary = _hexToColor('#1E293B');
  static final Color textSecondary = _hexToColor('#64748B');

  static final Color border = _hexToColor('#E2E8F0');
  static final Color borderFocus = Color(0xFF94B3FD);
}
