import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/veiculoCard.dart';

class VeiculoListBuilder extends StatefulWidget {
  const VeiculoListBuilder({super.key});

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
          itemCount: 3,
          itemBuilder: (context, index) {
            return VeiculoCard();
          }),
    );
  }
}
