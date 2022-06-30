import 'dart:ui';

class ChartData {
  ChartData(
    this.title,
    this.value,
    this.color, {
    this.size,
    this.key,
    this.id,
  });

  final String? id;
  final String title;
  final double value;
  final Color color;
  final String? size;
  final String? key;
}