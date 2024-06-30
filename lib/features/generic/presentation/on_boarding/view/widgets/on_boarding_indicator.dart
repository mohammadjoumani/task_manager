import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';

class OnBoardingIndicator extends StatelessWidget {
  final double angle;
  final int currentPage;
  final Widget child;

  const OnBoardingIndicator({
    super.key,
    required this.angle,
    required this.currentPage,
    required this.child,
  });

  Color _getPageIndicatorColor(int pageIndex, BuildContext context) {
    return currentPage > pageIndex ? Theme.of(context).primaryColor : ColorManager.colorBlack.withOpacity(0.25);
  }

  double get indicatorGap => pi / 12;

  double get indicatorLength => pi / 3;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OnBoardingIndicatorPainter(
        color: _getPageIndicatorColor(0, context),
        startAngle: (4 * indicatorLength) - (indicatorLength + indicatorGap) + angle,
        indicatorLength: indicatorLength,
      ),
      child: CustomPaint(
        painter: _OnBoardingIndicatorPainter(
          color: _getPageIndicatorColor(1, context),
          startAngle: 4 * indicatorLength + angle,
          indicatorLength: indicatorLength,
        ),
        child: CustomPaint(
          painter: _OnBoardingIndicatorPainter(
            color: _getPageIndicatorColor(2, context),
            startAngle: (4 * indicatorLength) + (indicatorLength + indicatorGap) + angle,
            indicatorLength: indicatorLength,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _OnBoardingIndicatorPainter extends CustomPainter {
  final Color color;
  final double startAngle;
  final double indicatorLength;

  const _OnBoardingIndicatorPainter({
    required this.color,
    required this.startAngle,
    required this.indicatorLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.shortestSide + 12.0) / 2,
      ),
      startAngle,
      indicatorLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_OnBoardingIndicatorPainter oldDelegate) {
    return color != oldDelegate.color || startAngle != oldDelegate.startAngle;
  }
}
