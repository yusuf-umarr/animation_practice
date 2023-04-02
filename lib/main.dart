import 'package:flutter/material.dart';
import 'package:van_anime/views/example_eight.dart';
import 'package:van_anime/views/example_five.dart';
import 'package:van_anime/views/example_four.dart';
import 'package:van_anime/views/example_one.dart';
import 'package:van_anime/views/example_seven.dart';
import 'package:van_anime/views/example_six.dart';
import 'package:van_anime/views/example_three.dart';
import 'package:van_anime/views/exmaple_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const ExampleEight(),
    );
  }
}

