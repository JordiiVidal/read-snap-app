Map<String, int> formatMinutesToTime(int totalMinutes) {
  if (totalMinutes <= 0) {
    return {'hours': 0, 'minutes': 0};
  }

  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  return {'hours': hours, 'minutes': minutes};
}
