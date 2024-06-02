import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uff_caronas/controller/PedidoController.dart';
import 'package:uff_caronas/model/DAO/PedidoDAO.dart';
import 'package:uff_caronas/model/modelos/Pedido.dart';
import 'package:uff_caronas/view/custom_widgets/PedidoCard.dart';
import 'package:uff_caronas/view/custom_widgets/pedidoListBuilder.dart';
import 'package:uff_caronas/view/login.dart';

class PedidoArmazenado extends StatefulWidget {
  const PedidoArmazenado({super.key});

  @override
  State<PedidoArmazenado> createState() => _PedidoArmazenadoState();
}

class _PedidoArmazenadoState extends State<PedidoArmazenado> {
  List<Pedido> pedidos = [];
  DateFormat format = DateFormat("dd/MM/yyyy - HH:mm");

  DateTime now = DateTime.now().subtract(Duration(hours: 3));

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('pedidos')
        .snapshots()
        .listen((event) {
      _fetchPedidos().then((_) {
        _atualizarPedidos();
      });
    });
    print(now);
  }

  Future<void> _fetchPedidos() async {
    pedidos = await PedidoController().recuperarPedidosPorUsuario(user!.id)
        as List<Pedido>;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _atualizarPedidos() async {
    print('Função Atualizando pedidos');
    print(pedidos.length);
    for (int i = 0; i < pedidos.length; i++) {
      print('Pedido: ${pedidos[i].id}');
      if (pedidos[i].status == 'Pendente') {
        print('Estado atual pendente pendente');
        DateTime dataPedido = format.parse(pedidos[i].data);
        if (dataPedido.isBefore(now)) {
          print(dataPedido);
          print('Pedido expirado');
          await PedidoController()
              .atualizarStatusPedido(pedidos[i].id, 'Expirado');
        }
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    print(user!.id);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SafeArea(
              child: Container(
                height: screenSize.height * (100.0 / 800.0),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                    left: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                    bottom: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                  ),
                ),
                child: Container(
                  width: screenSize.width,
                  alignment: AlignmentDirectional.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * (25 / 360)),
                  child: Text(
                    'Pedidos Armazenados',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: screenSize.height * (28 / 800)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: PedidoListBuilder(pedidos: pedidos)),
          ],
        ));
  }
}
