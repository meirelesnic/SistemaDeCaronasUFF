import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MotoristaAvaliacao extends StatefulWidget {
  const MotoristaAvaliacao({super.key});

  @override
  State<MotoristaAvaliacao> createState() => _MotoristaAvaliacaoState();
}

class _MotoristaAvaliacaoState extends State<MotoristaAvaliacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('motorista avaliacao')),
    );
  }
}