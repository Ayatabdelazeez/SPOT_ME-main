import 'package:flutter/material.dart';

/// Original, hand-drawn (code-drawn) product illustrations for the ads
/// system. Nothing here is a photo, logo, or copy of a real brand —
/// every shape is built from scratch so there's zero copyright risk,
/// and it renders fully offline (no network image needed).
enum AdVisual { energyCan, waterBottle, jersey, sneaker, cleats }

class AdIllustration extends StatelessWidget {
  final AdVisual visual;
  final Color color;
  final double size;

  const AdIllustration({
    super.key,
    required this.visual,
    required this.color,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AdPainter(visual: visual, color: color),
      ),
    );
  }
}

class _AdPainter extends CustomPainter {
  final AdVisual visual;
  final Color color;

  _AdPainter({required this.visual, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    switch (visual) {
      case AdVisual.energyCan:
        _paintCan(canvas, size);
        break;
      case AdVisual.waterBottle:
        _paintBottle(canvas, size);
        break;
      case AdVisual.jersey:
        _paintJersey(canvas, size);
        break;
      case AdVisual.sneaker:
        _paintSneaker(canvas, size);
        break;
      case AdVisual.cleats:
        _paintCleats(canvas, size);
        break;
    }
  }

  // A stylised energy-drink can: rounded body + rim + a bolt graphic.
  void _paintCan(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bodyRect = Rect.fromLTWH(w * 0.28, h * 0.14, w * 0.44, h * 0.74);
    final bodyRRect = RRect.fromRectAndRadius(
      bodyRect,
      Radius.circular(w * 0.08),
    );

    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withOpacity(0.95), color.withOpacity(0.55)],
      ).createShader(bodyRect);

    canvas.drawRRect(bodyRRect, bodyPaint);

    // Rim highlight top
    final rimRect = Rect.fromLTWH(w * 0.28, h * 0.14, w * 0.44, h * 0.06);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rimRect, Radius.circular(w * 0.05)),
      Paint()..color = Colors.white.withOpacity(0.35),
    );

    // Vertical shine streak
    final shinePath = Path()
      ..moveTo(w * 0.36, h * 0.22)
      ..lineTo(w * 0.40, h * 0.22)
      ..lineTo(w * 0.36, h * 0.80)
      ..lineTo(w * 0.32, h * 0.80)
      ..close();
    canvas.drawPath(shinePath, Paint()..color = Colors.white.withOpacity(0.25));

    // Lightning bolt (brand-agnostic energy symbol)
    final bolt = Path()
      ..moveTo(w * 0.54, h * 0.32)
      ..lineTo(w * 0.42, h * 0.52)
      ..lineTo(w * 0.49, h * 0.52)
      ..lineTo(w * 0.45, h * 0.68)
      ..lineTo(w * 0.60, h * 0.46)
      ..lineTo(w * 0.52, h * 0.46)
      ..close();
    canvas.drawPath(bolt, Paint()..color = Colors.white.withOpacity(0.9));
  }

  // A simple sports water bottle with a cap and a water-level fill.
  void _paintBottle(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Cap
    final capRect = Rect.fromLTWH(w * 0.40, h * 0.08, w * 0.20, h * 0.10);
    canvas.drawRRect(
      RRect.fromRectAndRadius(capRect, Radius.circular(w * 0.03)),
      Paint()..color = color,
    );

    // Neck
    final neckRect = Rect.fromLTWH(w * 0.43, h * 0.17, w * 0.14, h * 0.08);
    canvas.drawRect(neckRect, Paint()..color = color.withOpacity(0.85));

    // Body (rounded)
    final bodyRect = Rect.fromLTWH(w * 0.30, h * 0.24, w * 0.40, h * 0.66);
    final bodyRRect = RRect.fromRectAndRadius(
      bodyRect,
      Radius.circular(w * 0.12),
    );

    canvas.drawRRect(
      bodyRRect,
      Paint()..color = Colors.white.withOpacity(0.10),
    );
    canvas.drawRRect(
      bodyRRect,
      Paint()
        ..color = color.withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.02,
    );

    // Water fill (bottom 55%)
    final fillTop = h * 0.24 + h * 0.66 * 0.45;
    final fillRect = Rect.fromLTWH(
      w * 0.30,
      fillTop,
      w * 0.40,
      h * 0.24 + h * 0.66 - fillTop,
    );
    canvas.save();
    canvas.clipRRect(bodyRRect);
    canvas.drawRect(fillRect, Paint()..color = color.withOpacity(0.55));
    canvas.restore();

    // Droplet icon on the label
    final drop = Path()
      ..moveTo(w * 0.50, h * 0.40)
      ..cubicTo(w * 0.58, h * 0.52, w * 0.58, h * 0.60, w * 0.50, h * 0.60)
      ..cubicTo(w * 0.42, h * 0.60, w * 0.42, h * 0.52, w * 0.50, h * 0.40)
      ..close();
    canvas.drawPath(drop, Paint()..color = Colors.white.withOpacity(0.85));
  }

  // A generic athletic jersey silhouette.
  void _paintJersey(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final jersey = Path()
      ..moveTo(w * 0.35, h * 0.16)
      ..lineTo(w * 0.20, h * 0.28)
      ..lineTo(w * 0.28, h * 0.40)
      ..lineTo(w * 0.34, h * 0.34)
      ..lineTo(w * 0.34, h * 0.85)
      ..lineTo(w * 0.66, h * 0.85)
      ..lineTo(w * 0.66, h * 0.34)
      ..lineTo(w * 0.72, h * 0.40)
      ..lineTo(w * 0.80, h * 0.28)
      ..lineTo(w * 0.65, h * 0.16)
      ..cubicTo(w * 0.60, h * 0.22, w * 0.40, h * 0.22, w * 0.35, h * 0.16)
      ..close();

    canvas.drawPath(
      jersey,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.95), color.withOpacity(0.6)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Collar
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.20),
        width: w * 0.14,
        height: h * 0.05,
      ),
      Paint()..color = Colors.white.withOpacity(0.8),
    );

    // Number
    final textPainter = TextPainter(
      text: TextSpan(
        text: "7",
        style: TextStyle(
          color: Colors.white.withOpacity(0.85),
          fontSize: w * 0.26,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(w * 0.5 - textPainter.width / 2, h * 0.48),
    );
  }

  // A generic athletic sneaker (side profile).
  void _paintSneaker(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final sole = Path()
      ..moveTo(w * 0.12, h * 0.78)
      ..quadraticBezierTo(w * 0.10, h * 0.88, w * 0.20, h * 0.88)
      ..lineTo(w * 0.85, h * 0.88)
      ..quadraticBezierTo(w * 0.92, h * 0.88, w * 0.90, h * 0.78)
      ..lineTo(w * 0.12, h * 0.78)
      ..close();
    canvas.drawPath(sole, Paint()..color = Colors.white.withOpacity(0.85));

    final upper = Path()
      ..moveTo(w * 0.14, h * 0.78)
      ..lineTo(w * 0.16, h * 0.55)
      ..quadraticBezierTo(w * 0.20, h * 0.40, w * 0.36, h * 0.36)
      ..lineTo(w * 0.62, h * 0.30)
      ..quadraticBezierTo(w * 0.80, h * 0.32, w * 0.86, h * 0.50)
      ..lineTo(w * 0.90, h * 0.78)
      ..close();

    canvas.drawPath(
      upper,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.95), color.withOpacity(0.6)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Swoosh-free stripe detail (generic diagonal stripe, not any real logo)
    final stripe = Path()
      ..moveTo(w * 0.40, h * 0.55)
      ..lineTo(w * 0.68, h * 0.42)
      ..lineTo(w * 0.72, h * 0.48)
      ..lineTo(w * 0.44, h * 0.62)
      ..close();
    canvas.drawPath(stripe, Paint()..color = Colors.white.withOpacity(0.8));

    // Laces
    final lacePaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = w * 0.015;
    for (var i = 0; i < 3; i++) {
      final y = h * (0.42 + i * 0.06);
      canvas.drawLine(
        Offset(w * 0.42, y),
        Offset(w * 0.58, y - h * 0.02),
        lacePaint,
      );
    }
  }

  // A generic football boot (side profile).
  void _paintCleats(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final sole = Path()
      ..moveTo(w * 0.10, h * 0.80)
      ..lineTo(w * 0.88, h * 0.80)
      ..lineTo(w * 0.88, h * 0.90)
      ..lineTo(w * 0.10, h * 0.90)
      ..close();
    canvas.drawPath(sole, Paint()..color = Colors.white.withOpacity(0.85));

    // Studs
    final studPaint = Paint()..color = Colors.white.withOpacity(0.6);
    for (var i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(w * (0.16 + i * 0.15), h * 0.92),
        w * 0.02,
        studPaint,
      );
    }

    final boot = Path()
      ..moveTo(w * 0.12, h * 0.80)
      ..quadraticBezierTo(w * 0.10, h * 0.55, w * 0.30, h * 0.45)
      ..lineTo(w * 0.66, h * 0.30)
      ..quadraticBezierTo(w * 0.84, h * 0.32, w * 0.88, h * 0.55)
      ..lineTo(w * 0.90, h * 0.80)
      ..close();

    canvas.drawPath(
      boot,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.95), color.withOpacity(0.6)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Laces
    final lacePaint = Paint()
      ..color = Colors.white.withOpacity(0.75)
      ..strokeWidth = w * 0.015;
    for (var i = 0; i < 3; i++) {
      final x = w * (0.42 + i * 0.07);
      canvas.drawLine(
        Offset(x, h * 0.42),
        Offset(x + w * 0.04, h * 0.56),
        lacePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AdPainter oldDelegate) {
    return oldDelegate.visual != visual || oldDelegate.color != color;
  }
}
