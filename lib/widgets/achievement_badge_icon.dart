import 'dart:math' as math;
import 'package:flutter/material.dart';

enum AchievementIconType {
  foodie,
  topReviewer,
  foodExplorer,
}

class AchievementBadgeIcon extends StatelessWidget {
  final AchievementIconType type;
  final double size;

  const AchievementBadgeIcon({
    super.key,
    required this.type,
    this.size = 54,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFF7ECE0),
        border: Border.all(
          color: const Color(0xFFD6A87C),
          width: 1.4,
        ),
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.52, size * 0.52),
          painter: _BadgeIconPainter(type),
        ),
      ),
    );
  }
}

class _BadgeIconPainter extends CustomPainter {
  final AchievementIconType type;

  _BadgeIconPainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeColor = Color(0xFFA75B2E);
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    switch (type) {
      case AchievementIconType.foodie:
        // Fork on left (3 prongs), Knife on right
        // Fork
        final forkX = w * 0.32;
        // Handle
        canvas.drawLine(Offset(forkX, h * 0.46), Offset(forkX, h * 0.92), paint);
        // Prongs base U-shape
        final forkPath = Path()
          ..moveTo(forkX - w * 0.13, h * 0.12)
          ..lineTo(forkX - w * 0.13, h * 0.32)
          ..arcToPoint(
            Offset(forkX + w * 0.13, h * 0.32),
            radius: Radius.circular(w * 0.13),
            clockwise: false,
          )
          ..lineTo(forkX + w * 0.13, h * 0.12);
        canvas.drawPath(forkPath, paint);
        // Middle prong
        canvas.drawLine(Offset(forkX, h * 0.12), Offset(forkX, h * 0.38), paint);

        // Knife
        final knifeX = w * 0.68;
        // Handle
        canvas.drawLine(Offset(knifeX, h * 0.46), Offset(knifeX, h * 0.92), paint);
        // Blade
        final knifePath = Path()
          ..moveTo(knifeX, h * 0.46)
          ..lineTo(knifeX, h * 0.12)
          ..quadraticBezierTo(knifeX + w * 0.15, h * 0.16, knifeX + w * 0.15, h * 0.35)
          ..lineTo(knifeX, h * 0.46);
        canvas.drawPath(knifePath, paint);
        break;

      case AchievementIconType.topReviewer:
        // Document / notepad with pencil writing on it
        final padRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.15, h * 0.18, w * 0.58, h * 0.68),
          const Radius.circular(3),
        );
        canvas.drawRRect(padRect, paint);

        // Lines on note
        canvas.drawLine(Offset(w * 0.26, h * 0.36), Offset(w * 0.58, h * 0.36), paint);
        canvas.drawLine(Offset(w * 0.26, h * 0.50), Offset(w * 0.58, h * 0.50), paint);
        canvas.drawLine(Offset(w * 0.26, h * 0.64), Offset(w * 0.46, h * 0.64), paint);

        // Pencil angled on right
        final pencilPath = Path()
          ..moveTo(w * 0.88, h * 0.14)
          ..lineTo(w * 0.62, h * 0.58)
          ..lineTo(w * 0.58, h * 0.72)
          ..lineTo(w * 0.70, h * 0.68)
          ..lineTo(w * 0.94, h * 0.22)
          ..close();
        canvas.drawPath(pencilPath, paint);
        break;

      case AchievementIconType.foodExplorer:
        // Compass outer circle and needle
        final center = Offset(w * 0.5, h * 0.5);
        final r = w * 0.44;
        canvas.drawCircle(center, r, paint);
        canvas.drawCircle(center, r * 0.28, paint);

        // Compass needle (pointing northwest / southeast)
        final needlePath = Path();
        final angle = -math.pi / 4; // 45 deg northwest
        final nx = math.cos(angle) * (r * 0.75);
        final ny = math.sin(angle) * (r * 0.75);
        final px = math.cos(angle + math.pi / 2) * (r * 0.25);
        final py = math.sin(angle + math.pi / 2) * (r * 0.25);

        needlePath.moveTo(center.dx + nx, center.dy + ny);
        needlePath.lineTo(center.dx + px, center.dy + py);
        needlePath.lineTo(center.dx - nx, center.dy - ny);
        needlePath.lineTo(center.dx - px, center.dy - py);
        needlePath.close();

        canvas.drawPath(needlePath, paint);
        canvas.drawCircle(center, 2, fillPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _BadgeIconPainter oldDelegate) =>
      oldDelegate.type != type;
}

