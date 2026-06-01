import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatefulWidget {
  final double size;
  final Color petalColor;

  const CustomLoadingIndicator({
    super.key,
    this.size = 80,
    this.petalColor = const Color(0xFFD4AF37),
  });

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _FloralPainter(
              progress: _controller.value,
              petalColor: widget.petalColor,
            ),
          ),
        );
      },
    );
  }
}

class _FloralPainter extends CustomPainter {
  final double progress;
  final Color petalColor;


  final Paint _centerPaint = Paint()..style = PaintingStyle.fill;
  final Paint _petalPaint = Paint()..style = PaintingStyle.fill;

  _FloralPainter({required this.progress, required this.petalColor}) {
    _centerPaint.color = petalColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;
    
    final center = Offset(size.width / 2, size.height / 2);
    const petalCount = 8;
    final maxRadius = size.width / 2;
    final petalRadiusBase = maxRadius * 0.35;
    final distance = maxRadius * 0.45;


    for (int i = 0; i < petalCount; i++) {

      final baseAngle = (i * 2 * math.pi / petalCount) + (progress * 2 * math.pi);
      
      final petalCenter = Offset(
        center.dx + distance * math.cos(baseAngle),
        center.dy + distance * math.sin(baseAngle),
      );


      final scale = 0.6 + 0.4 * math.sin(progress * 2 * math.pi + i * 0.8);
      final currentPetalRadius = petalRadiusBase * scale;

      _drawPetal(canvas, petalCenter, currentPetalRadius, baseAngle);
    }


    canvas.drawCircle(center, 6, _centerPaint);
  }

  void _drawPetal(
    Canvas canvas,
    Offset center,
    double radius,
    double angle,
  ) {
    final path = Path();
    final length = radius * 1.5;
    final cosAngle = math.cos(angle);
    final sinAngle = math.sin(angle);
    final cosAnglePlus90 = math.cos(angle + math.pi / 2);
    final sinAnglePlus90 = math.sin(angle + math.pi / 2);
    final cosAngleMinus90 = math.cos(angle - math.pi / 2);
    final sinAngleMinus90 = math.sin(angle - math.pi / 2);

    path.moveTo(
      center.dx + radius * 0.3 * cosAnglePlus90,
      center.dy + radius * 0.3 * sinAnglePlus90,
    );

    path.quadraticBezierTo(
      center.dx + length * cosAngle,
      center.dy + length * sinAngle,
      center.dx + radius * 0.3 * cosAngleMinus90,
      center.dy + radius * 0.3 * sinAngleMinus90,
    );

    path.quadraticBezierTo(
      center.dx - length * 0.3 * cosAngle,
      center.dy - length * 0.3 * sinAngle,
      center.dx + radius * 0.3 * cosAnglePlus90,
      center.dy + radius * 0.3 * sinAnglePlus90,
    );

    path.close();

    _petalPaint.shader = RadialGradient(
      colors: [
        petalColor.withOpacity(0.9),
        petalColor.withOpacity(0.3),
      ],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawPath(path, _petalPaint);
  }

  @override
  bool shouldRepaint(covariant _FloralPainter oldDelegate) {
    return true;
  }
}
