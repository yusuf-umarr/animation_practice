import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  // late Animation<double> _animation; bind to parent controller
  late Tween<double> _animation; // tween value between two i.e 0 & 1

  double withAndHeight = 100;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 20,
      ),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 30,
      ),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 40,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: withAndHeight,
            width: double.infinity,
          ),
          AnimatedBuilder(
            animation: Listenable.merge([
              _xController,
              _yController,
              _zController,
            ]),
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateY(_animation.evaluate(_xController))
                  ..rotateX(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                  children: [
                    //back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, -withAndHeight)),
                      child: Container(
                        color: Colors.purple,
                        height: withAndHeight,
                        width: withAndHeight,
                      ),
                    ),
                    //left
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        color: Colors.red,
                        height: withAndHeight,
                        width: withAndHeight,
                      ),
                    ),
                    //right
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        color: Colors.blue,
                        height: withAndHeight,
                        width: withAndHeight,
                      ),
                    ),

                    //front
                    Container(
                      color: Colors.green,
                      height: withAndHeight,
                      width: withAndHeight,
                    ),
                    //top side
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        color: Colors.orange,
                        height: withAndHeight,
                        width: withAndHeight,
                      ),
                    ),
                    //bottom side
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        color: Colors.brown,
                        height: withAndHeight,
                        width: withAndHeight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
