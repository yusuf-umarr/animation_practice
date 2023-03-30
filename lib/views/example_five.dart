import 'package:flutter/material.dart';

const defaultWidth = 100.0;

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  var _isZoomedIn = false;
  var _buttonTitle = "Zoom In";
  var _width;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // _width = size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: _width,
              curve: _curve,
              duration: const Duration(milliseconds: 370),
              child: Image.asset("assets/images/cover-image.jpeg"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isZoomedIn = !_isZoomedIn;
                  _buttonTitle = _isZoomedIn ? "Zoom Out" : "Zoom In";
                  _width = _isZoomedIn ? defaultWidth : size.width;
                  _curve = _isZoomedIn ? Curves.bounceInOut : Curves.bounceIn;
                });
              },
              child: Text(_buttonTitle),
            )
          ],
        ),
      ),
    );
  }
}
