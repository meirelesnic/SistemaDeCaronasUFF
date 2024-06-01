import 'package:flutter/material.dart';
import 'package:uff_caronas/controller/PedidoController.dart';
import 'package:uff_caronas/model/modelos/Pedido.dart';

class PedidoCard extends StatefulWidget {
  final Pedido pedido;
  const PedidoCard({super.key, required this.pedido});

  @override
  State<PedidoCard> createState() => _PedidoCardState();
}

class _PedidoCardState extends State<PedidoCard> {
  int widthScale = 500;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: screenSize.width * (313 / 360),
        height: screenSize.height * (150 / 800),
        child: Container(
          padding: EdgeInsets.all(screenSize.width * (10 / 360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //origem
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * (5 / widthScale)),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: screenSize.width * (20 / widthScale),
                        ),
                      ),
                      Text(
                        widget.pedido.nomeOrigem,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (14 / 800)),
                      )
                    ],
                  ),
                  Text(
                    widget.pedido.status,
                    style: widget.pedido.status == "Pendente"
                        ? TextStyle(
                            color: const Color.fromARGB(255, 187, 72, 72))
                        : TextStyle(color: Colors.grey.shade700),
                  )
                ],
              ),
              //destino
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.sports_score_rounded,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Text(
                    widget.pedido.nomeDestino,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * (14 / 800)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //data
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * (5 / widthScale)),
                        child: Icon(
                          Icons.schedule_rounded,
                          size: screenSize.width * (20 / widthScale),
                        ),
                      ),
                      Text(
                        widget.pedido.data,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (14 / 800)),
                      )
                    ],
                  ),
                  FilledButton(
                    onPressed: () {
                      //deletar pedido
                      PedidoController().deletarPedido(widget.pedido.id);
                      setState(() {});
                    },
                    child: Text('Apagar'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(255, 187, 72, 72)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
