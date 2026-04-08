import 'package:flutter/material.dart';

class CircularProgressButton extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onTap;

  const CircularProgressButton({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentStep + 1) / totalSteps;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(100, 100),
            painter: ArcPainter(progress),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1F2B38),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;

  ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF74B1FF),
        Color(0xFF3B76C1),
      ],
    );

    final Paint paint = Paint()
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    const double startAngle = -3.14 / 2;
    final double sweepAngle = -2 * 3.14 * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}