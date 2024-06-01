import 'package:flutter/material.dart';
import 'package:uff_caronas/controller/PedidoController.dart';
import 'package:uff_caronas/model/DAO/CaronaDAO.dart';
import 'package:uff_caronas/view/login.dart';
import '../controller/CaronaController.dart';
import '../model/modelos/Carona.dart';
import '../model/modelos/CaronaInfo.dart';
import 'custom_widgets/BuscaCaronaListBuilder.dart';
import 'package:lottie/lottie.dart';

class BuscaCarona extends StatefulWidget {
  final List<double> origemCoord;
  final List<double> destinoCoord;
  final String dataCarona;
  final String horaCarona;
  final String nomeOrigem;
  final String nomeDestino;

  const BuscaCarona(
      {super.key,
      required this.dataCarona,
      required this.horaCarona,
      required this.origemCoord,
      required this.destinoCoord,
      required this.nomeOrigem,
      required this.nomeDestino});

  @override
  State<BuscaCarona> createState() => _BuscaCaronaState();
}

class _BuscaCaronaState extends State<BuscaCarona> {
  late CaronaController caronaController;

  List<Map<String, dynamic>> caronas = [];
  List<Carona> caronasList = [];
  List<CaronaInfo> caronaInfosList = [];
  List<double> rota = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    caronaController = CaronaController();
    buscarCaronas(); // Chamada para buscar as caronas ao inicializar o estado do widget
  }

  Future<void> buscarCaronas() async {
    caronas = await caronaController.buscarCaronasCompativeis(
        widget.origemCoord[0],
        widget.origemCoord[1],
        widget.destinoCoord[0],
        widget.destinoCoord[1],
        widget.dataCarona);

    caronasList = caronas.map((mapa) => mapa['carona'] as Carona).toList();
    caronaInfosList = caronas.map((mapa) => CaronaInfo(
      carona: mapa['carona'] as Carona,
      walkingDistanceStart: mapa['walkingDistanceStart'],
      walkingDistanceEnd: mapa['walkingDistanceEnd'],
      pickupPoint: mapa['pickupPoint'] as List<double>,
      dropoffPoint: mapa['dropoffPoint'] as List<double>,
      routeDuration: mapa['routeDuration'] as int,
      route: mapa['route'] as List,
      walkRouteEnd: mapa['walkRouteEnd'] as List,
      walkRouteStart: mapa['walkRouteStart'] as List,
    )).toList();

    for (var caronaInfo in caronaInfosList) {
      print('Carona para ${caronaInfo.carona.origemDestino}:');
      print(
          'Distância a pé até o ponto de embarque: ${caronaInfo.walkingDistanceStart} metros');
      print(
          'Distância a pé até o ponto de desembarque: ${caronaInfo.walkingDistanceEnd} metros');
      print('Duração da rota: ${caronaInfo.routeDuration} minutos');
      print('${caronaInfo.pickupPoint} embarque');
      print('${caronaInfo.dropoffPoint} desembarque');
      print('------------------------------------');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.background,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Buscar Caronas',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.background)),
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          widget.dataCarona,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Spacer(),
                        Text(
                          '${caronasList.length} Caronas encontradas',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
            Expanded(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Lottie.asset(
                          'image/load.json', // substitua 'animation.json' pelo nome do seu arquivo de animação
                          //fit: BoxFit.cover,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.6),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Buscando Caronas',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        )
                      ],
                    )
                  : _buildCaronasList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaronasList() {
    if (caronas.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text('Nenhuma carona encontrada para esta data'),
            TextButton(
                onPressed: () => {
                      PedidoController().salvarPedido(
                          widget.dataCarona + " - " + widget.horaCarona,
                          widget.nomeOrigem,
                          widget.nomeDestino,
                          widget.origemCoord,
                          widget.destinoCoord,
                          user!.id),
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Pedido de Carona criado com sucesso!"),
                            content:
                                Text("Aguarde a confirmação do motorista."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              )
                            ],
                          );
                        },
                      )
                    },
                child: Text("Criar um pedido de Carona")),
          ],
        ),
      );
    } else {
      return BuscaCaronaListBuilder(
          caronas: caronasList,
          caronasInfo: caronaInfosList,
          or: widget.origemCoord,
          de: widget.destinoCoord);
    }
  }
}
