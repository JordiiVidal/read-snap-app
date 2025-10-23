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
    this.gap = 9,
    this.spaceBetween = 6,
    this.valueFontSize = 25,
    this.unitFontSize = 14,
    this.shortText = false,
    super.key,
  });

  List<Widget> _buildTimeWidget() {
    final List<Widget> timeWidgets = [];
    final valueStyle = TextStyle(
      fontSize: valueFontSize,
      fontWeight: FontWeight.bold,
    );
    final unitStyle = TextStyle(
      fontSize: unitFontSize,
      fontWeight: FontWeight.w300,
      color: Colors.black54,
    );

    final hours = timeParts['hours']!;
    final minutes = timeParts['minutes']!;
    final isMinutesOnly = hours == 0;

    if (hours == 0 && minutes == 0) {
      return [
        Text('0', style: valueStyle),
        SizedBox(width: spaceBetween),
        Text('min', style: unitStyle),
      ];
    }

    if (hours > 0) {
      timeWidgets.add(Text('$hours', style: valueStyle));
      timeWidgets.add(SizedBox(width: spaceBetween));
      timeWidgets.add(Text('h', style: unitStyle));
      timeWidgets.add(SizedBox(width: gap));
    }

    if (minutes > 0) {
      timeWidgets.add(Text('$minutes', style: valueStyle));
      timeWidgets.add(SizedBox(width: spaceBetween));
      timeWidgets.add(
        Text(isMinutesOnly && !shortText ? 'minutes' : 'min', style: unitStyle),
      );
    }

    return timeWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: _buildTimeWidget(),
    );
  }
}
