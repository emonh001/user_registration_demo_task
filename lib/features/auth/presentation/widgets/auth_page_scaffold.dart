import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AuthPageScaffold extends StatelessWidget {
  const AuthPageScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: _DottedBackground(),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AuthHeader(title: title),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.sizeOf(context).height - 70,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neutral,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.login_rounded,
          color: AppColors.white,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DottedBackground extends StatelessWidget {
  const _DottedBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBackgroundPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _DottedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = AppColors.tertiary;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final dotPaint = Paint()
      ..color = AppColors.white.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    const double spacing = 14;
    const double radius = 1;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}