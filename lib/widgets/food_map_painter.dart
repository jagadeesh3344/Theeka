import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class FoodMapPainter extends CustomPainter {
  final Offset? selectedCoordinates;

  FoodMapPainter({this.selectedCoordinates});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Map Base Background
    final bgPaint = Paint()..color = ThekaaColors.mapBackground;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // 2. Botanical Garden Green Zone (organic polygon/blob on right)
    final parkPaint = Paint()
      ..color = const Color(0xFFD5DFCA)
      ..style = PaintingStyle.fill;

    final parkPath = Path();
    parkPath.moveTo(w * 0.62, 0);
    parkPath.quadraticBezierTo(w * 0.58, h * 0.35, w * 0.65, h * 0.60);
    parkPath.quadraticBezierTo(w * 0.75, h * 0.70, w * 0.95, h * 0.65);
    parkPath.lineTo(w, h * 0.65);
    parkPath.lineTo(w, 0);
    parkPath.close();
    canvas.drawPath(parkPath, parkPaint);

    // 3. Roads (drawn with smooth lines in off-white)
    final roadPaint = Paint()
      ..color = ThekaaColors.mapRoads
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Secondary minor roads
    roadPaint.strokeWidth = 5.0;
    canvas.drawLine(Offset(0, h * 0.28), Offset(w * 0.45, h * 0.18), roadPaint);
    canvas.drawLine(Offset(w * 0.78, 0), Offset(w * 0.68, h * 0.45), roadPaint);

    // Major road 1: Top left diagonal cutting through
    roadPaint.strokeWidth = 9.0;
    final road1 = Path();
    road1.moveTo(w * 0.33, 0);
    road1.lineTo(w * 0.42, h * 0.50);
    road1.lineTo(w * 0.70, h);
    canvas.drawPath(road1, roadPaint);

    // Major road 2: Transverse diagonal highway (Old Mumbai Highway direction)
    roadPaint.strokeWidth = 8.0;
    final road2 = Path();
    road2.moveTo(0, h * 0.48);
    road2.lineTo(w * 0.48, h * 0.54);
    road2.lineTo(w, h * 0.58);
    canvas.drawPath(road2, roadPaint);

    // Major road 3: Diagonal cutting from botanical down to bottom-left
    roadPaint.strokeWidth = 7.5;
    final road3 = Path();
    road3.moveTo(w * 0.76, 0);
    road3.lineTo(w * 0.45, h * 0.55);
    road3.lineTo(0, h * 0.88);
    canvas.drawPath(road3, roadPaint);

    // 4. Locality Labels
    // "GACHIBOWLI"
    final textPainterGachibowli = TextPainter(
      text: const TextSpan(
        text: 'GACHIBOWLI',
        style: TextStyle(
          color: Color(0xFF5A483E),
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterGachibowli.paint(canvas, Offset(w * 0.08, h * 0.24));

    // "Botanical Garden"
    final textPainterBotanical = TextPainter(
      text: const TextSpan(
        text: 'Botanical Garden',
        style: TextStyle(
          color: Color(0xFF53634C),
          fontSize: 9.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterBotanical.paint(canvas, Offset(w * 0.66, h * 0.42));

    // "Old Mumbai Highway"
    final textPainterHighway = TextPainter(
      text: const TextSpan(
        text: 'Old Mumbai Highway',
        style: TextStyle(
          color: Color(0xFF756557),
          fontSize: 8.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterHighway.paint(canvas, Offset(w * 0.32, h * 0.68));

    // 5. Markers
    // Marker 1: Cutlery near center (x: 0.58, y: 0.41)
    _drawCutleryMarker(canvas, Offset(w * 0.58, h * 0.41), radius: 12.0);

    // Marker 2: Cutlery bottom-left (x: 0.23, y: 0.82)
    _drawCutleryMarker(canvas, Offset(w * 0.23, h * 0.82), radius: 12.0);

    // Marker 3: Home / Hut inside Botanical Garden with outer ring (x: 0.74, y: 0.46)
    _drawHomeMarker(canvas, Offset(w * 0.74, h * 0.46), radius: 12.5);

    // 6. Draw Highlight Selection Ring if any restaurant is selected
    if (selectedCoordinates != null) {
      final selCenter = Offset(selectedCoordinates!.dx * w, selectedCoordinates!.dy * h);
      final selPaint = Paint()
        ..color = ThekaaColors.terracotta
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(selCenter, 18.0, selPaint);
    }
  }

  void _drawCutleryMarker(Canvas canvas, Offset center, {required double radius}) {
    // Terracotta circle
    final paint = Paint()
      ..color = ThekaaColors.terracotta
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);

    // Cutlery icon: Fork & Spoon/Knife
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round;

    // Fork (left side)
    final fx = center.dx - 3.2;
    final fy = center.dy;
    // Handle
    canvas.drawLine(Offset(fx, fy - 1), Offset(fx, fy + 5.5), iconPaint);
    // Prongs
    canvas.drawLine(Offset(fx - 2, fy - 5.5), Offset(fx - 2, fy - 1), iconPaint);
    canvas.drawLine(Offset(fx, fy - 5.5), Offset(fx, fy - 1), iconPaint);
    canvas.drawLine(Offset(fx + 2, fy - 5.5), Offset(fx + 2, fy - 1), iconPaint);
    // Cross bar
    canvas.drawLine(Offset(fx - 2, fy - 1), Offset(fx + 2, fy - 1), iconPaint);

    // Knife (right side)
    final kx = center.dx + 3.2;
    canvas.drawLine(Offset(kx, fy - 5.5), Offset(kx, fy + 5.5), iconPaint);
    // Blade curve
    final blade = Path()
      ..moveTo(kx, fy - 5.5)
      ..quadraticBezierTo(kx + 3, fy - 2.5, kx, fy);
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(blade, fillPaint);
  }

  void _drawHomeMarker(Canvas canvas, Offset center, {required double radius}) {
    // Outer white halo ring
    final haloPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius + 2.0, haloPaint);

    // Terracotta circle
    final circlePaint = Paint()
      ..color = ThekaaColors.terracotta
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    // Home / Hut outline
    final homePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final hx = center.dx;
    final hy = center.dy;
    final homePath = Path();
    // Roof
    homePath.moveTo(hx - 5.5, hy - 0.5);
    homePath.lineTo(hx, hy - 5.5);
    homePath.lineTo(hx + 5.5, hy - 0.5);
    // Walls
    homePath.lineTo(hx + 4.2, hy - 0.5);
    homePath.lineTo(hx + 4.2, hy + 4.5);
    homePath.lineTo(hx - 4.2, hy + 4.5);
    homePath.lineTo(hx - 4.2, hy - 0.5);
    canvas.drawPath(homePath, homePaint);

    // Door
    canvas.drawLine(Offset(hx - 1.5, hy + 4.5), Offset(hx - 1.5, hy + 1.5), homePaint);
    canvas.drawLine(Offset(hx + 1.5, hy + 4.5), Offset(hx + 1.5, hy + 1.5), homePaint);
    canvas.drawLine(Offset(hx - 1.5, hy + 1.5), Offset(hx + 1.5, hy + 1.5), homePaint);
  }

  @override
  bool shouldRepaint(covariant FoodMapPainter oldDelegate) =>
      oldDelegate.selectedCoordinates != selectedCoordinates;
}
