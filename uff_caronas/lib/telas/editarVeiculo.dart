import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditarVeiculo extends StatefulWidget {
  const EditarVeiculo({super.key});

  @override
  State<EditarVeiculo> createState() => _EditarVeiculoState();
}

class _EditarVeiculoState extends State<EditarVeiculo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('editar veiculo')),
    );
  }
}