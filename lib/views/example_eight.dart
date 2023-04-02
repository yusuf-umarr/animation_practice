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
      body: Container(),
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
      begin: 0.0,
      end: -pi / 2,
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
    return const Placeholder();
  }
}
