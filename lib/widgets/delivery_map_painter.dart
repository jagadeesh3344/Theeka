import 'package:flutter/material.dart';
import '../models/address.dart';
import '../theme/thekaa_colors.dart';

class DeliveryMapPainter extends CustomPainter {
  final AddressType addressType;

  DeliveryMapPainter({required this.addressType});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Map Base Background
    final bgPaint = Paint()..color = ThekaaColors.mapBackground;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // 2. Botanical Garden Green Zone
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

    // 3. Roads
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

    // "Botanical garden"
    final textPainterBotanical = TextPainter(
      text: const TextSpan(
        text: 'Botanical garden',
        style: TextStyle(
          color: Color(0xFF53634C),
          fontSize: 9.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterBotanical.paint(canvas, Offset(w * 0.68, h * 0.32));

    // "Old Mumbai Highway"
    final textPainterHighway = TextPainter(
      text: const TextSpan(
        text: 'Old Mumbai Highway',
        style: TextStyle(
          color: Color(0xFF6B5848),
          fontSize: 8.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterHighway.paint(canvas, Offset(w * 0.33, h * 0.67));

    // 5. Markers
    // Marker A (Restaurant 1 - top middle)
    _drawMarker(
      canvas: canvas,
      center: Offset(w * 0.60, h * 0.30),
      radius: 13.0,
      icon: Icons.restaurant_rounded,
      color: ThekaaColors.terracotta,
    );

    // Marker B (Restaurant 2 - bottom left)
    _drawMarker(
      canvas: canvas,
      center: Offset(w * 0.24, h * 0.72),
      radius: 13.0,
      icon: Icons.restaurant_rounded,
      color: ThekaaColors.terracotta,
    );

    // Marker C (Delivery Destination Table - inside Botanical garden)
    final deliveryPos = Offset(w * 0.76, h * 0.38);
    // Draw subtle outer selection halo
    final haloPaint = Paint()
      ..color = ThekaaColors.terracotta.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawCircle(deliveryPos, 16.5, haloPaint);

    final IconData destinationIcon;
    switch (addressType) {
      case AddressType.home:
        destinationIcon = Icons.home_rounded;
        break;
      case AddressType.work:
        destinationIcon = Icons.work_rounded;
        break;
      case AddressType.other:
        destinationIcon = Icons.location_on_rounded;
        break;
    }

    _drawMarker(
      canvas: canvas,
      center: deliveryPos,
      radius: 14.0,
      icon: destinationIcon,
      color: ThekaaColors.terracotta,
      hasBorder: true,
    );

    // 6. Map Control GPS Icon on bottom right
    final gpsCenter = Offset(w * 0.90, h * 0.70);
    final gpsBgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(gpsCenter, 14.0, gpsBgPaint);

    final gpsBorderPaint = Paint()
      ..color = ThekaaColors.border.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(gpsCenter, 14.0, gpsBorderPaint);

    _drawIcon(
      canvas: canvas,
      center: gpsCenter,
      icon: Icons.my_location_rounded,
      color: ThekaaColors.terracotta,
      size: 15.0,
    );
  }

  void _drawMarker({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required IconData icon,
    required Color color,
    bool hasBorder = false,
  }) {
    if (hasBorder) {
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(center, radius + 1.0, borderPaint);
    }

    final markerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, markerPaint);

    _drawIcon(
      canvas: canvas,
      center: center,
      icon: icon,
      color: Colors.white,
      size: radius * 1.15,
    );
  }

  void _drawIcon({
    required Canvas canvas,
    required Offset center,
    required IconData icon,
    required Color color,
    required double size,
  }) {
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          color: color,
          fontSize: size,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    iconPainter.paint(
      canvas,
      Offset(center.dx - iconPainter.width / 2, center.dy - iconPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant DeliveryMapPainter oldDelegate) {
    return oldDelegate.addressType != addressType;
  }
}

