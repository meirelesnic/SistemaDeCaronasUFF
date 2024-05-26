import 'package:flutter/material.dart';
import '../../model/modelos/Carona.dart';
import 'caronaCard.dart';

class CaronaListBuilder extends StatefulWidget {
  final List<Carona> caronas;

  const CaronaListBuilder({required this.caronas, Key? key}) : super(key: key);

  @override
  State<CaronaListBuilder> createState() => _CaronaListBuilderState();
}

class _CaronaListBuilderState extends State<CaronaListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.caronas.length,
      itemBuilder: (context, index) {
        return CaronaCard(carona: widget.caronas[index]);
      },
    );
  }

  @override
  void didUpdateWidget(covariant CaronaListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.caronas != widget.caronas) {
      setState(() {});
    }
  }
}