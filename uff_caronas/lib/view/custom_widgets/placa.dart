import 'package:flutter/cupertino.dart';

class Placa extends StatefulWidget {
  final String placa;
  final double width;
  const Placa({super.key, required this.placa, required this.width});

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
    print('verifica placa');
    return placa[4].contains(RegExp(r'[0-9]'));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return !mercosul ? 
    Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('image/mercosul.png',
          width: widget.width,
        ),
        Text(widget.placa,
          style: TextStyle(
            fontSize: widget.width * 0.2,
            fontFamily: 'mercosul'
          ),
        )
      ],
    ) 
    : 
     Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('image/antiga.png',
          width: widget.width,
        ),
        Column(
          children: [
            Container(height: widget.width * 0.05,),
            Text(widget.placa.substring(0, 3) + '-' + widget.placa.substring(3),
          style: TextStyle(
            fontSize: widget.width * 0.2,
            fontFamily: 'antiga'
          ),
        )
          ],
        ),
        
      ],
    );
  }
}