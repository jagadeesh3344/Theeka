import 'package:flutter/material.dart';
import '../theme/thekaa_colors.dart';

class LiveRouteMapPainter extends CustomPainter {
  final Offset riderLocation;
  final Offset restaurantLocation;
  final Offset dropoffLocation;

  LiveRouteMapPainter({
    this.riderLocation = const Offset(0.60, 0.28),
    this.restaurantLocation = const Offset(0.25, 0.70),
    this.dropoffLocation = const Offset(0.76, 0.38),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Map Base Background
    final bgPaint = Paint()..color = ThekaaColors.mapBackground;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // 2. Botanical Garden Green Zone on top right
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

    // 3. Roads Network
    final roadPaint = Paint()
      ..color = ThekaaColors.mapRoads
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Minor roads
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

    // Major road 2: Transverse highway across
    roadPaint.strokeWidth = 8.0;
    final road2 = Path();
    road2.moveTo(0, h * 0.48);
    road2.lineTo(w * 0.48, h * 0.54);
    road2.lineTo(w, h * 0.58);
    canvas.drawPath(road2, roadPaint);

    // Major road 3: Diagonal cutting from botanical to bottom-left
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
    textPainterGachibowli.paint(canvas, Offset(w * 0.08, h * 0.14));

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
    textPainterBotanical.paint(canvas, Offset(w * 0.68, h * 0.18));

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
    textPainterHighway.paint(canvas, Offset(w * 0.35, h * 0.84));

    // 5. Active Delivery Route Line
    final routePaint = Paint()
      ..color = ThekaaColors.terracotta
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final pRestaurant = Offset(w * restaurantLocation.dx, h * restaurantLocation.dy);
    final pJunction = Offset(w * 0.46, h * 0.54);
    final pRider = Offset(w * riderLocation.dx, h * riderLocation.dy);
    final pDropoff = Offset(w * dropoffLocation.dx, h * dropoffLocation.dy);

    final routePath = Path();
    routePath.moveTo(pRestaurant.dx, pRestaurant.dy);
    routePath.lineTo(pJunction.dx, pJunction.dy);
    routePath.lineTo(pRider.dx, pRider.dy);
    routePath.lineTo(pDropoff.dx, pDropoff.dy);
    canvas.drawPath(routePath, routePaint);

    // 6. Markers
    // Marker A: Restaurant Pickup
    _drawMarker(
      canvas: canvas,
      center: pRestaurant,
      radius: 14.0,
      icon: Icons.restaurant_rounded,
      color: ThekaaColors.terracotta,
      hasBorder: true,
    );

    // Marker B: Destination Drop-off
    _drawMarker(
      canvas: canvas,
      center: pDropoff,
      radius: 14.0,
      icon: Icons.home_rounded,
      color: const Color(0xFF8A4A24),
      hasBorder: true,
    );

    // Marker C: Rider Live Location (Active on route)
    _drawMarker(
      canvas: canvas,
      center: pRider,
      radius: 14.5,
      icon: Icons.directions_bike_rounded,
      color: ThekaaColors.terracotta,
      hasBorder: true,
    );

    // 7. Map Control GPS Icon on bottom right
    final gpsCenter = Offset(w * 0.90, h * 0.84);
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
  bool shouldRepaint(covariant LiveRouteMapPainter oldDelegate) {
    return oldDelegate.riderLocation != riderLocation ||
        oldDelegate.restaurantLocation != restaurantLocation ||
        oldDelegate.dropoffLocation != dropoffLocation;
  }
}
