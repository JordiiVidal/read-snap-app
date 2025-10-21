import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  final Map<String, int> timeParts;
  final double gap;
  final double spaceBetween;

  const TimeDisplay({
    required this.timeParts,
    this.gap = 9,
    this.spaceBetween = 6,
    super.key,
  });

  List<Widget> _buildTimeWidget() {
    final List<Widget> timeWidgets = [];
    final valueStyle = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
    final unitStyle = const TextStyle(
      fontSize: 14,
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
      timeWidgets.add(Text(isMinutesOnly ? 'minutes' : 'm', style: unitStyle));
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
