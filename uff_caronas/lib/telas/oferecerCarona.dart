import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OferecerCarona extends StatefulWidget {
  const OferecerCarona({super.key});

  @override
  State<OferecerCarona> createState() => _OferecerCaronaState();
}

class _OferecerCaronaState extends State<OferecerCarona> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('oferecer carona')),
    );
  }
}