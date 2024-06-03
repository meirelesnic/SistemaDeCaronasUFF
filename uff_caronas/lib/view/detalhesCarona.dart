import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:uff_caronas/view/custom_widgets/placa.dart';
import '../model/Services/mapa.dart';
import 'package:flutter/services.dart';

import '../model/modelos/Carona.dart';
import '../model/modelos/Usuario.dart';
import '../model/modelos/Veiculo.dart';

class DetalhesCarona extends StatefulWidget {
  final List<LatLng> route;
  final List<LatLng> coordinates;
  final Carona carona;
  final Veiculo veiculo;
  final Usuario motorista;
  const DetalhesCarona({super.key, required this.route, required this.coordinates, required this.carona, required this.veiculo, required this.motorista});

  @override
  State<DetalhesCarona> createState() => _DetalhesCaronaState();
}

class _DetalhesCaronaState extends State<DetalhesCarona> {
  bool chat = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: screenSize.width * (280 / 360),
            child: Mapa(
              route: [widget.route],
              coordinates: widget.coordinates,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenSize.width * (13 / 360)),
                child: Column(
                  children: [
                    Container(
                      width: screenSize.width * (313 / 360),
                      padding: EdgeInsets.all(screenSize.width * (9 / 360)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.motorista.fotoUrl),
                            backgroundColor: Colors.blue,
                            radius: screenSize.width * (38 / 360),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.motorista.nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'Motorista',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '4,8',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Icon(Icons.star_rounded),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //ver reputacao ID
                                      },
                                      child: Text('Ver reputação'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (39 / 360)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: screenSize.width * (20 / 360),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Text(
                                  widget.carona.origemLocal,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.height * (18 / 800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Row(
                            children: [
                              Icon(
                                Icons.sports_score_rounded,
                                size: screenSize.width * (20 / 360),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: Text(
                                  widget.carona.origemDestino,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.height * (18 / 800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: screenSize.width * (20 / 360),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                '${widget.carona.data} - ${widget.carona.hora}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.height * (18 / 800),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10,),
                          //Veiculo
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: EdgeInsets.all(18),
                              //color: Theme.of(context).colorScheme.inversePrimary,
                              decoration: BoxDecoration(
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
                                  top: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer, // cor da linha de contorno
                                    width: 2.0, // largura da linha de contorno
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                        "image/car_icons/carro_${widget.veiculo.cor.toLowerCase()}.png",
                                        width: screenSize.width * (32 / 360),
                                      ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Text(widget.veiculo.marca,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: screenSize.height * (14 / 800),
                                        ),
                                      ),
                                      Text(widget.veiculo.modelo,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.height * (16 / 800),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Placa(placa: widget.veiculo.placa, width: screenSize.width * (115/360)),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.person_outline),
                              Text(' ${widget.carona.vagas}' ' Passageiros',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.height * (18 / 800),
                                  ),
                              ),
                              Spacer(),
                              !chat
                                  ? FilledButton(
                                      onPressed: () {
                                        // Tela mensagem, passando ID do chat
                                      },
                                      child: Text('Chat'),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 120, // altura fixa para o ListView.builder
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: screenSize.width * (7 / 360)),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: screenSize.width * (23 / 360),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
