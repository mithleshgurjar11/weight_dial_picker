import 'dart:math';
import 'package:flutter/material.dart';

class StaticDialWithRotatingPointer extends CustomPainter {
  final double angle;
  final int min;
  final int max;
  final String unit;

  StaticDialWithRotatingPointer({
    required this.angle,
    required this.min,
    required this.max,
    required this.unit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2.2;

    final tickPaint = Paint()..color = const Color(0xFF525252);
    final highlightPaint = Paint()
      ..color = const Color(0xFF525252)
      ..strokeWidth = 3;
    final selectedPaint = Paint()
      ..color = const Color(0xFF3563DE)
      ..strokeWidth = 4;

    final totalTicks = max - min;
    final anglePerTick = pi / totalTicks;
    final labelRadius = radius - 30;
    final tickInnerRadius = radius - 10;
    final tickOuterRadius = radius + 40;

    final progress = angle / pi;
    final currentValue = (min + (max - min) * progress).round();

    for (int i = 0; i <= totalTicks; i++) {
      final tickAngle = pi + i * anglePerTick;
      final value = i + min;

      bool isBig = false;
      if (unit == 'kg') {
        isBig = value % 10 == 0;
      } else {
        List<int> allowedLabels = List.generate(19, (index) => (20 + index * 10));
        List<int> allowedLb = allowedLabels.map((kg) => (kg * 2.20462).round()).toList();
        isBig = allowedLb.contains(value);
      }

      final tickStart = Offset(
        center.dx + (isBig ? (radius - 20) : tickInnerRadius) * cos(tickAngle),
        center.dy + (isBig ? (radius - 20) : tickInnerRadius) * sin(tickAngle),
      );
      final tickEnd = Offset(
        center.dx + tickOuterRadius * cos(tickAngle),
        center.dy + tickOuterRadius * sin(tickAngle),
      );

      final paintToUse = (value == currentValue)
          ? selectedPaint
          : isBig
          ? highlightPaint
          : tickPaint;

      canvas.drawLine(tickStart, tickEnd, paintToUse);

      if (isBig) {
        final labelOffset = Offset(
          center.dx + labelRadius * cos(tickAngle),
          center.dy + labelRadius * sin(tickAngle),
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: "$value",
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          labelOffset - Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}