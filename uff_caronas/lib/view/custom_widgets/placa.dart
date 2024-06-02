import 'package:flutter/cupertino.dart';

class Placa extends StatefulWidget {
  final String placa;
  const Placa({super.key, required this.placa});

  @override
  State<Placa> createState() => _PlacaState();
}

class _PlacaState extends State<Placa> {
  late bool mercosul;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mercosul = placaMercosul(widget.placa);
  }
  bool placaMercosul(String placa) {
    return placa[4].contains(RegExp(r'[0-9]'));
  }

  @override
  Widget build(BuildContext context) {
    return !mercosul ? Text('Mercosul'):Text('Antiga');
  }
}