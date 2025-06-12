import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final double dashWidth;
  final double dashSpace;

  const DashedLine({
    super.key,
    this.color = Colors.black,
    this.height = 1,
    this.width = 100,
    this.dashWidth = 5,
    this.dashSpace = 5,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: SizedBox(height: height, width: width),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    super.repaint,
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < size.width; i += (dashWidth + dashSpace).toInt()) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i + dashWidth, 0), paint);
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => false;
}
