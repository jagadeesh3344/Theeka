import 'package:flutter/material.dart';

/// Minimal line-art Hyderabad monument illustration
class HyderabadMonumentIllustration extends StatelessWidget {
  final double width;
  final double height;
  final Color strokeColor;

  const HyderabadMonumentIllustration({
    super.key,
    this.width = 75,
    this.height = 60,
    this.strokeColor = const Color(0xFFD49A73),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: HyderabadMonumentPainter(strokeColor: strokeColor),
      ),
    );
  }
}

class HyderabadMonumentPainter extends CustomPainter {
  final Color strokeColor;

  HyderabadMonumentPainter({required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // 1. Base line
    final baseY = h * 0.95;
    canvas.drawLine(Offset(w * 0.05, baseY), Offset(w * 0.95, baseY), paint);

    // 2. Main structure boundaries
    final leftWall = w * 0.22;
    final rightWall = w * 0.78;
    final wallTop = h * 0.52;

    // Outer wall base plinth
    canvas.drawLine(Offset(leftWall, baseY), Offset(leftWall, wallTop), paint);
    canvas.drawLine(Offset(rightWall, baseY), Offset(rightWall, wallTop), paint);
    canvas.drawLine(Offset(leftWall - 3, wallTop), Offset(rightWall + 3, wallTop), paint);

    // Stepped parapet above wall
    final parapetY = h * 0.44;
    canvas.drawLine(Offset(w * 0.28, parapetY), Offset(w * 0.72, parapetY), paint);
    canvas.drawLine(Offset(w * 0.28, wallTop), Offset(w * 0.28, parapetY), paint);
    canvas.drawLine(Offset(w * 0.72, wallTop), Offset(w * 0.72, parapetY), paint);

    // 3. Central Bulbous Heritage Dome
    final domeCenterX = w * 0.50;
    final domeBaseY = parapetY;
    final domePath = Path();
    domePath.moveTo(w * 0.35, domeBaseY);
    // Left bulbous flare to apex
    domePath.cubicTo(
      w * 0.31, domeBaseY - (h * 0.12),
      w * 0.42, domeBaseY - (h * 0.32),
      domeCenterX, domeBaseY - (h * 0.35),
    );
    // Right curve back to base
    domePath.cubicTo(
      w * 0.58, domeBaseY - (h * 0.32),
      w * 0.69, domeBaseY - (h * 0.12),
      w * 0.65, domeBaseY,
    );
    canvas.drawPath(domePath, paint);

    // Dome finial / spire
    canvas.drawLine(
      Offset(domeCenterX, domeBaseY - (h * 0.35)),
      Offset(domeCenterX, domeBaseY - (h * 0.44)),
      paint,
    );
    canvas.drawCircle(Offset(domeCenterX, domeBaseY - (h * 0.43)), 1.2, paint);

    // 4. Central Grand Arch (Iwan)
    final archWidth = w * 0.18;
    final archLeft = domeCenterX - archWidth / 2;
    final archRight = domeCenterX + archWidth / 2;
    final archSpringY = h * 0.74;

    final archPath = Path();
    archPath.moveTo(archLeft, baseY);
    archPath.lineTo(archLeft, archSpringY);
    // Pointed ogee arch
    archPath.cubicTo(
      archLeft, archSpringY - 10,
      domeCenterX - 3, archSpringY - 15,
      domeCenterX, h * 0.60,
    );
    archPath.cubicTo(
      domeCenterX + 3, archSpringY - 15,
      archRight, archSpringY - 10,
      archRight, archSpringY,
    );
    archPath.lineTo(archRight, baseY);
    canvas.drawPath(archPath, paint);

    // 5. Left Minaret
    _drawMinaret(canvas, paint, x: w * 0.14, baseY: baseY, h: h, isLeft: true);

    // 6. Right Minaret
    _drawMinaret(canvas, paint, x: w * 0.86, baseY: baseY, h: h, isLeft: false);

    // 7. Side mini arches on facade
    _drawMiniArch(canvas, paint, w * 0.28, baseY, h * 0.78, 6);
    _drawMiniArch(canvas, paint, w * 0.72, baseY, h * 0.78, 6);
  }

  void _drawMinaret(Canvas canvas, Paint paint, {
    required double x,
    required double baseY,
    required double h,
    required bool isLeft,
  }) {
    const mw = 4.5;
    final shaftTop = h * 0.38;

    // Shaft lines
    canvas.drawLine(Offset(x - mw, baseY), Offset(x - mw, shaftTop), paint);
    canvas.drawLine(Offset(x + mw, baseY), Offset(x + mw, shaftTop), paint);

    // Lower balcony ring
    canvas.drawLine(Offset(x - mw - 2, h * 0.65), Offset(x + mw + 2, h * 0.65), paint);

    // Upper balcony ring
    canvas.drawLine(Offset(x - mw - 2.5, shaftTop), Offset(x + mw + 2.5, shaftTop), paint);

    // Pavilion / Chhatri under cupola
    final chhatriTop = h * 0.26;
    canvas.drawLine(Offset(x - mw + 1, shaftTop), Offset(x - mw + 1, chhatriTop), paint);
    canvas.drawLine(Offset(x + mw - 1, shaftTop), Offset(x + mw - 1, chhatriTop), paint);

    // Minaret Cupola / small dome
    final cupolaPath = Path();
    cupolaPath.moveTo(x - mw - 0.5, chhatriTop);
    cupolaPath.cubicTo(
      x - mw - 1, chhatriTop - (h * 0.08),
      x + mw + 1, chhatriTop - (h * 0.08),
      x + mw + 0.5, chhatriTop,
    );
    canvas.drawPath(cupolaPath, paint);

    // Spire
    canvas.drawLine(Offset(x, chhatriTop - (h * 0.08)), Offset(x, chhatriTop - (h * 0.16)), paint);
  }

  void _drawMiniArch(Canvas canvas, Paint paint, double cx, double baseY, double topY, double w) {
    final path = Path();
    path.moveTo(cx - w / 2, baseY);
    path.lineTo(cx - w / 2, topY + 4);
    path.quadraticBezierTo(cx, topY, cx + w / 2, topY + 4);
    path.lineTo(cx + w / 2, baseY);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
