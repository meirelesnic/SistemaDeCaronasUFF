import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:uff_caronas/view/custom_widgets/placa.dart';
import '../model/Services/mapa.dart';
import 'package:flutter/services.dart';

class DetalhesCarona extends StatefulWidget {
  final List<LatLng> route;
  final List<LatLng> coordinates;
  const DetalhesCarona({super.key, required this.route, required this.coordinates});

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
            height: screenSize.width * (330 / 360),
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
                            backgroundColor: Colors.blue,
                            radius: screenSize.width * (38 / 360),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User Name',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (39 / 360)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_sharp),
                              Text('Origem'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.sports_score_rounded),
                              Text('Destino'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule),
                              Text('00/00/2024 - 09:00'),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'image/car_icons/carro_amarelo.png',
                                width: screenSize.width * (73 / 360),
                              ),
                              Column(
                                children: [
                                  Text('Renault Sandero'),
                                  Placa(placa: 'ABC1734'),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person_outline),
                              Text('4 Passageiros'),
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
