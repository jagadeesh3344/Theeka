import 'package:flutter/material.dart';

/// Custom Indian tiffin dabba (stacked food container) icon
class DabbaIcon extends StatelessWidget {
  final double size;
  final Color color;

  const DabbaIcon({
    super.key,
    this.size = 24,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DabbaPainter(color: color),
      ),
    );
  }
}

class _DabbaPainter extends CustomPainter {
  final Color color;

  _DabbaPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // 1. Top carry handle arch
    final handlePath = Path();
    handlePath.moveTo(w * 0.32, h * 0.24);
    handlePath.quadraticBezierTo(w * 0.50, h * 0.04, w * 0.68, h * 0.24);
    canvas.drawPath(handlePath, strokePaint);

    // 2. Three stacked tiffin tiers (containers)
    final tierWidth = w * 0.62;
    final tierLeft = (w - tierWidth) / 2;
    final tierHeight = h * 0.18;
    final radius = Radius.circular(tierHeight * 0.35);

    // Tier 1 (top)
    final r1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(tierLeft, h * 0.24, tierWidth, tierHeight),
      radius,
    );
    canvas.drawRRect(r1, strokePaint);

    // Tier 2 (middle)
    final r2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(tierLeft, h * 0.45, tierWidth, tierHeight),
      radius,
    );
    canvas.drawRRect(r2, strokePaint);

    // Tier 3 (bottom)
    final r3 = RRect.fromRectAndRadius(
      Rect.fromLTWH(tierLeft, h * 0.66, tierWidth, tierHeight),
      radius,
    );
    canvas.drawRRect(r3, strokePaint);

    // 3. Side vertical clamp / fastening latch bars
    final clampPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    // Left clamp line
    canvas.drawLine(Offset(tierLeft - 1.5, h * 0.26), Offset(tierLeft - 1.5, h * 0.82), clampPaint);
    // Right clamp line
    canvas.drawLine(Offset(tierLeft + tierWidth + 1.5, h * 0.26), Offset(tierLeft + tierWidth + 1.5, h * 0.82), clampPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

