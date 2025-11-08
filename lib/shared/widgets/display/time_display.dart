import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  final Map<String, int> timeParts;
  final double gap;
  final double spaceBetween;
  final double valueFontSize;
  final double unitFontSize;
  final bool shortText;

  const TimeDisplay(
    this.timeParts, {
    super.key,
    this.gap = 9,
    this.spaceBetween = 6,
    this.valueFontSize = 25,
    this.unitFontSize = 14,
    this.shortText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hours = timeParts['hours'] ?? 0;
    final minutes = timeParts['minutes'] ?? 0;

    final valueStyle = theme.textTheme.headlineSmall?.copyWith(
      fontSize: valueFontSize,
      fontWeight: FontWeight.bold,
    );

    final unitStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: unitFontSize,
      fontWeight: FontWeight.w300,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: _buildTimeWidgets(hours, minutes, valueStyle, unitStyle),
    );
  }

  List<Widget> _buildTimeWidgets(
    int hours,
    int minutes,
    TextStyle? valueStyle,
    TextStyle? unitStyle,
  ) {
    // Si ambos son cero
    if (hours == 0 && minutes == 0) {
      return [
        Text('0', style: valueStyle),
        SizedBox(width: spaceBetween),
        Text('min', style: unitStyle),
      ];
    }

    final widgets = <Widget>[];

    // Horas
    if (hours > 0) {
      widgets.addAll([
        Text('$hours', style: valueStyle),
        SizedBox(width: spaceBetween),
        Text('h', style: unitStyle),
        if (minutes > 0) SizedBox(width: gap),
      ]);
    }

    // Minutos
    if (minutes > 0) {
      final isMinutesOnly = hours == 0;
      widgets.addAll([
        Text('$minutes', style: valueStyle),
        SizedBox(width: spaceBetween),
        Text(isMinutesOnly && !shortText ? 'minutes' : 'min', style: unitStyle),
      ]);
    }

    return widgets;
  }
}
