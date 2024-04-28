import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaronaEmEspera extends StatefulWidget {
  const CaronaEmEspera({super.key});

  @override
  State<CaronaEmEspera> createState() => _CaronaEmEsperaState();
}

class _CaronaEmEsperaState extends State<CaronaEmEspera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('editar perfil')),
    );
  }
}