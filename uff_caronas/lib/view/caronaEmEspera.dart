import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/controller/CaronaController.dart';
import 'package:uff_caronas/controller/PedidoPassageiroController.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/model/modelos/PedidoPassageiro.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';
import 'package:uff_caronas/view/custom_widgets/usuarioCard.dart';
import 'package:uff_caronas/view/custom_widgets/passageiroListBuilder.dart';
import 'package:uff_caronas/view/login.dart';

class CaronaEmEspera extends StatefulWidget {
  const CaronaEmEspera({super.key});

  @override
  State<CaronaEmEspera> createState() => _CaronaEmEsperaState();
}

class _CaronaEmEsperaState extends State<CaronaEmEspera> {
  List<PedidoPassageiro> pedidosPasssageiro = [];
  Map<Carona?, List<PedidoPassageiro?>> caronaPedidoMap = {};
  List<Carona?> caronas = [];
  List<List<PedidoPassageiro?>> pedidosAgrupados = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('pedidoPassageiro')
        .snapshots()
        .listen((event) {
      recuperarPedidos();
    });
  }

  /// Incicializar a variável carona

  Future<void> recuperarPedidos() async {
    PedidoPassageiroController pedidoPassageiroController =
        PedidoPassageiroController();

    try {
      pedidosPasssageiro = await pedidoPassageiroController
              .recuperarPassageirosPendentesPorUsuario(user!.id)
          as List<PedidoPassageiro>;

      await pedidoPassageiroController
          .atalizarPedidosPassageiroExpirados(pedidosPasssageiro);

      caronaPedidoMap = await pedidoPassageiroController
              .recuperarCaronasComPedidos(pedidosPasssageiro)
          as Map<Carona?, List<PedidoPassageiro?>>;
    } catch (e) {
      print('Erro ao recuperar pedidos: $e');
    }

    caronas = caronaPedidoMap.keys.toList();
    pedidosAgrupados = caronaPedidoMap.values.toList();

    /// Atualizar a tela
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(caronaPedidoMap);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Aprovar Passageiros',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.background,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : caronaPedidoMap.length == 0
              ? Center(
                  child: Text(
                    'Não há passageiros no momento',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: caronaPedidoMap.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PassageiroListBuilder(
                      pedidos: pedidosAgrupados[index],
                      carona: caronas[index],
                    );
                  }),
    );
  }
}
