import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Services/mapa.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Carona em espera'),
            Mapa(),
            Mapa(),
            Mapa(),
            Mapa(),
            
          ],
        ),
      ),
    );
  }
}