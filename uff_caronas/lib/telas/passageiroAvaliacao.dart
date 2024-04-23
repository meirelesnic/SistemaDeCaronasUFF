import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassageiroAvaliacao extends StatefulWidget {
  const PassageiroAvaliacao({super.key});

  @override
  State<PassageiroAvaliacao> createState() => _PassageiroAvaliacaoState();
}

class _PassageiroAvaliacaoState extends State<PassageiroAvaliacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('passageiro avaliacao')),
    );
  }
}