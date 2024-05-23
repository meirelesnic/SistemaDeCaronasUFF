import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/veiculoCard.dart';

import '../../model/modelos/Veiculo.dart';

class VeiculoListBuilder extends StatefulWidget {
  final List<Veiculo> veiculos;

  const VeiculoListBuilder({Key? key, required this.veiculos}) : super(key: key);

  @override
  State<VeiculoListBuilder> createState() => _VeiculoListBuilderState();
}

class _VeiculoListBuilderState extends State<VeiculoListBuilder> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (10 / 360)),
      child: ListView.builder(
          itemCount: widget.veiculos.length,
          itemBuilder: (context, index) {
            return VeiculoCard(veiculo: widget.veiculos[index]);
          }),
    );
  }
}
