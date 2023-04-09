import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final double size;

  const CustomCircularProgressIndicator({
    this.strokeWidth = 20.0,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomCircularProgressIndicatorPainter(
        strokeWidth: strokeWidth,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}

class _CustomCircularProgressIndicatorPainter extends CustomPainter {
  final double strokeWidth;

  _CustomCircularProgressIndicatorPainter({
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final progress = math.pi * 2 / 3;
    final startAngle = math.pi / 2 - progress / 2;
    final sweepAngle = progress;
    final useCenter = false;

    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(_CustomCircularProgressIndicatorPainter oldDelegate) {
    return false;
  }
}
