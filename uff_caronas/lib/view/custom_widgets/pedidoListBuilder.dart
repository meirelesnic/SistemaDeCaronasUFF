import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/pedidoCard.dart';

class PedidoListBuilder extends StatefulWidget {
  const PedidoListBuilder({Key? key}) : super(key: key);

  @override
  State<PedidoListBuilder> createState() => _PedidoListBuilderState();
}

class _PedidoListBuilderState extends State<PedidoListBuilder> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (10 / 360)),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return PedidoCard(); // Replace with the desired widget for Pedido item
        },
      ),
    );
  }
}
