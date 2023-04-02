import 'package:flutter/material.dart';
import 'dart:math' as math;

Color getRandomColor() => Color(
      0xFF000000 +
          math.Random().nextInt(
            0x00FFFFFF,
          ),
    );

class ExampleSix extends StatefulWidget {
  const ExampleSix({super.key});

  @override
  State<ExampleSix> createState() => _ExampleSixState();
}

class _ExampleSixState extends State<ExampleSix> {
  var _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: ClipPath(
        clipper: CicleClipper(),
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 1),
          tween: ColorTween(
            begin: getRandomColor(),
            end: _color,
          ),
          onEnd: () {
            setState(() {
              _color = getRandomColor(); 
            });
          },
          builder: (BuildContext context, Color? color, Widget? child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                color!,
                BlendMode.srcATop,
              ),
              child: child,
            );
          },
          child: Container(
            color: Colors.red,
            height: size.height / 2,
            width: size.width / 2,
          ),
        ),
      ),
    ));
  }
}

class CicleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
