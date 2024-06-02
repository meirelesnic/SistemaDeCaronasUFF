import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uff_caronas/controller/PedidoController.dart';
import 'package:uff_caronas/model/modelos/Pedido.dart';
import 'package:uff_caronas/view/custom_widgets/pedidoCard.dart';

class PedidoListBuilder extends StatefulWidget {
  final List<Pedido> pedidos;
  const PedidoListBuilder({Key? key, required this.pedidos}) : super(key: key);

  @override
  State<PedidoListBuilder> createState() => _PedidoListBuilderState();
}

class _PedidoListBuilderState extends State<PedidoListBuilder> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (10 / 360)),
      child: ListView.builder(
        itemCount: widget.pedidos.length,
        itemBuilder: (context, index) {
          return PedidoCard(pedido: widget.pedidos[index]);
        },
      ),
    );
  }
}
