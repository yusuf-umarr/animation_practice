// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class ExampleSeven extends StatefulWidget {
  const ExampleSeven({super.key});

  @override
  State<ExampleSeven> createState() => _ExampleSevenState();
}

class _ExampleSevenState extends State<ExampleSeven>
    with TickerProviderStateMixin {
  late AnimationController _sideController;
  late Animation<int> _sideAnimation;

  late AnimationController _radiusController;
  late Animation<double> _radiusAnimation;

  late AnimationController _rotationContoller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _initSideAnimation();
    _initRadiusAnimation();
    _initRotationAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _sideController.dispose();
    _radiusController.dispose();
    _rotationContoller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _sideController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationContoller.repeat(reverse: true);
    super.didChangeDependencies();
  }

  void _initSideAnimation() {
    _sideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sideAnimation = IntTween(
      begin: 5,
      end: 10,
    ).animate(
      _sideController,
    );
  }

  void _initRadiusAnimation() {
    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _radiusAnimation = Tween(begin: 20.0, end: 400.0)
        .chain(
          CurveTween(curve: Curves.bounceInOut),
        )
        .animate(_radiusController);
  }

  void _initRotationAnimation() {
    _rotationContoller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _rotationAnimation = Tween(begin: 2.0, end: 2 * pi)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_rotationContoller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _sideAnimation,
            _radiusController,
            _rotationAnimation,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_rotationAnimation.value)
                ..rotateY(_rotationAnimation.value)
                ..rotateZ(_rotationAnimation.value),
              child: CustomPaint(
                painter: Polygon(sides: _sideAnimation.value),
                child: SizedBox(
                  width: _radiusAnimation.value,
                  height: _radiusAnimation.value,
                ),
              ),
            );
          }),
    ));
  }
}

class Polygon extends CustomPainter {
  final int sides;
  Polygon({
    required this.sides,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final angle = (2 * pi) / sides;

    final angles = List.generate(sides, (index) => index * angle);

    final radius = size.width / 2;

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
  //true
}
