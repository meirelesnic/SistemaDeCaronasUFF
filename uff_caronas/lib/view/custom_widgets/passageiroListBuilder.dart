import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/controller/CaronaController.dart';
import 'package:uff_caronas/controller/PedidoPassageiroController.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/model/modelos/PedidoPassageiro.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';
import 'package:uff_caronas/view/custom_widgets/usuarioCard.dart';

class PassageiroListBuilder extends StatefulWidget {
  final List<PedidoPassageiro?> pedidos;
  final Carona? carona;
  const PassageiroListBuilder(
      {super.key, required this.pedidos, required this.carona});

  @override
  State<PassageiroListBuilder> createState() => _PassageiroListBuilderState();
}

class _PassageiroListBuilderState extends State<PassageiroListBuilder> {
  List<Usuario?> usuarios = [];
  bool _isLoading = true;
  void _onDismissed(
      DismissDirection direction, int index, String pedidoPassageiroId) {
    PedidoPassageiroController pedidoPassageiroController =
        PedidoPassageiroController();
    // CaronaController caronaController = CaronaController();

    setState(() {
      widget.pedidos.removeAt(index);
      usuarios.removeAt(index);
    });
    // Executa a ação de acordo com a direção do dismiss
    if (direction == DismissDirection.endToStart) {
      // implementar adicionar passageiro na carna
      pedidoPassageiroController.recusarPassageiro(pedidoPassageiroId);
    } else if (direction == DismissDirection.startToEnd) {
      pedidoPassageiroController.aceitarPassageiro(pedidoPassageiroId);
    }
  }

  Future<void> _recuperarUsuarios() async {
    for (PedidoPassageiro? pedido in widget.pedidos) {
      Usuario? usuario =
          await UsuarioController().recuperarUsuario(pedido!.userId);
      usuarios.add(usuario);
      print(usuarios);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('usuarios')
        .snapshots()
        .listen((event) {
      _recuperarUsuarios();
    });
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screenSize.width * (10 / 360)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Destino: ${widget.carona!.origemDestino}',
              style: TextStyle(
                  fontSize: 30, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.access_time,
                          size: 16, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${widget.carona!.data} - ${widget.carona!.hora}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ],
                ),
                Text('Vagas: ${widget.carona!.vagas}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16)),
              ],
            ),
            Divider(),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: widget.pedidos.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      if (index >= usuarios.length) {
                        return SizedBox.shrink();
                      }
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Dismissible(
                              key: Key(
                                  widget.pedidos[index]!.id + index.toString()),
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) => _onDismissed(
                                  direction, index, widget.pedidos[index]!.id),
                              background: Container(
                                height: screenSize.width * (105 / 360),
                                margin: EdgeInsets.symmetric(
                                    vertical: screenSize.width * (8 / 360)),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.green,
                                ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(Icons.check, color: Colors.white),
                              ),
                              secondaryBackground: Container(
                                height: screenSize.width * (105 / 360),
                                margin: EdgeInsets.symmetric(
                                    vertical: screenSize.width * (8 / 360)),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.red,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: UsuarioCard(user: usuarios[index]!)),
                        ),
                      );
                    }),
          ],
        ));
  }
}
