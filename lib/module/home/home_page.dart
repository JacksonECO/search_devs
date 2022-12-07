import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 100;
    width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 30),
          Center(
            child: Image.asset(
              'assets/imgs/logo.png',
              height: 68,
              // width: width * 80,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: min(width * 90, 600),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Buscar',
                hintText: 'username',
                prefixIcon: Icon(Icons.search),
              ),
              onFieldSubmitted: (value) {
                Navigator.of(context).pushNamed('/profile/', arguments: value.replaceAll('@', ''));
              },
            ),
          ),
        ],
      ),
    );
  }
}
