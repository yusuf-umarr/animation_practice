// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ExampleEight extends StatefulWidget {
  const ExampleEight({super.key});

  @override
  State<ExampleEight> createState() => _ExampleEightState();
}

class _ExampleEightState extends State<ExampleEight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyDrawer(
        drawer: Material(
          child: Container(
            color: const Color(0xff24283b),
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 100, left: 120),
                itemCount: 20,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Text(
                      "Item $index",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Drawer",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            color: Color(0xff414868),
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const MyDrawer({
    Key? key,
    required this.child,
    required this.drawer,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation<double> _yRotationAnimationForChild;

  late AnimationController _xControllerForDrawer;
  late Animation<double> _yRotationAnimationForDrawer;

  @override
  void initState() {
    _initChildAnimation();
    _initDrawerAnimation();

    super.initState();
  }

  void _initChildAnimation() {
    _xControllerForChild = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _yRotationAnimationForChild = Tween<double>(
      begin: 0.0,
      end: -pi / 2,
    ).animate(_xControllerForChild);
  }

  void _initDrawerAnimation() {
    _xControllerForDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _yRotationAnimationForDrawer = Tween<double>(
      begin: -pi / 2.7,
      end: 0.0,
    ).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    final maxDrag = screenWidht * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _xControllerForChild.value += delta;
        _xControllerForDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value < 0.5) {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
          animation: Listenable.merge([
            _xControllerForChild,
            _xControllerForDrawer,
          ]),
          builder: (context, _) {
            return Stack(
              children: [
                Container(),
                Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(_xControllerForChild.value * maxDrag)
                      ..rotateY(_yRotationAnimationForChild.value),
                    child: widget.child),
                Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                          -screenWidht + _xControllerForDrawer.value * maxDrag)
                      ..rotateY(_yRotationAnimationForDrawer.value),
                    child: widget.drawer),
              ],
            );
          }),
    );
  }
}
