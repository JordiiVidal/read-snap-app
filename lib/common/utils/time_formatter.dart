String formatMinutesToTime(int totalMinutes) {
  if (totalMinutes <= 0) {
    return '0 min';
  }
  if (totalMinutes < 60) {
    return '$totalMinutes min';
  }

  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  final hourPart = '${hours}h';
  final minPart = minutes > 0 ? ' ${minutes}m' : '';

  return '$hourPart$minPart';
}
