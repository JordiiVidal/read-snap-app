import 'package:flutter/material.dart';

Color _hexToColor(String hexCode) {
  return Color(int.parse(hexCode.replaceFirst('#', '0xFF')));
}

class AppColors {
  static final Color primary = _hexToColor('#556CF6');
  static final Color primaryVariant = _hexToColor('#4452D6');
  static final Color secondary = _hexToColor('#8E94A7');
  static final Color success = _hexToColor('#27AE60');
  static final Color warning = _hexToColor('#F4B740');
  static final Color error = _hexToColor('#E74C3C');

  static final Color background = _hexToColor('#F8FAFC');
  static final Color surface = _hexToColor('#FFFFFF');

  static final Color textPrimary = _hexToColor('#1E293B');
  static final Color textSecondary = _hexToColor('#64748B');

  static final Color border = _hexToColor('#E5E7EB');
  static final Color borderFocus = _hexToColor('#A5B4FC');
}
