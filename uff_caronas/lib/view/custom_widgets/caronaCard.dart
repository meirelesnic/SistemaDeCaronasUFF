import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/view/detalhesCarona.dart';
import '../../controller/VeiculoController.dart';


import '../../model/Services/routeService.dart';
import '../../model/modelos/Usuario.dart';
import '../../model/modelos/Veiculo.dart';

class CaronaCard extends StatefulWidget {
  final Carona carona;

  const CaronaCard({super.key, required this.carona});

  @override
  State<CaronaCard> createState() => _CaronaCardState();
}

class _CaronaCardState extends State<CaronaCard> {
  int widthScale = 500;
  late RouteService routeService;
  List<LatLng> route = [];

  @override
  void initState() {
    routeService = RouteService();
    super.initState();
  }

  Future<void> _getRoute() async{
    List<LatLng> result = await routeService.getRouteLatLng(widget.carona.origem[0], widget.carona.origem[1], widget.carona.dest[0], widget.carona.dest[1]);
      setState(() {
        route = result;
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        UsuarioController().recuperarUsuario(widget.carona.motoristaId),
        VeiculoController().recuperarVeiculoDoc(widget.carona.veiculoId) ?? Future.value(null)
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(width: 15); // Mostra um indicador de progresso enquanto os dados estão sendo carregados
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}'); // Exibe uma mensagem de erro se houver algum erro
        } else {
          Usuario? motorista = snapshot.data?[0] as Usuario?;
          Veiculo? veiculo = snapshot.data?[1] as Veiculo?;
          return _buildCaronaCard(context, motorista, veiculo); // Constrói o widget do CaronaCard com os dados do motorista e veículo
        }
      },
    );
  }

  Widget _buildCaronaCard(BuildContext context, Usuario? motorista, Veiculo? veiculo) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: screenSize.width * (313 / 360),
        child: Container(
          padding: EdgeInsets.all(screenSize.width * (10 / 360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: screenSize.width * (25 / 360),
                    backgroundColor: Colors.blue,
                    backgroundImage: motorista?.fotoUrl != null
                        ? NetworkImage(motorista!.fotoUrl)
                        : null,
                    child: motorista?.fotoUrl == null
                        ? const Icon(Icons.person, size: 30)
                        : null,
                  ),
                  Container(width: screenSize.width * (12 / widthScale)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        motorista?.nome ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenSize.height * (20 / 800),
                          height: 0,
                        ),
                      ),
                      Text(
                        'Motorista',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenSize.height * (12 / 800),
                          height: 0,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '4,8',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: screenSize.height * (13 / 800),
                            ),
                          ),
                          const Icon(Icons.star_rate_rounded),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.carona.origemLocal,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * (14 / 800),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.sports_score_rounded,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.carona.origemDestino,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * (14 / 800),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.schedule_rounded,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Text(
                    '${widget.carona.data} - ${widget.carona.hora}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.height * (14 / 800),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                        child: Icon(
                          Icons.directions_car_filled_outlined,
                          size: screenSize.width * (20 / widthScale),
                        ),
                      ),
                      Text(
                        veiculo != null ? '${veiculo.marca} ${veiculo.modelo}' : 'Veículo desconhecido',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.height * (14 / 800),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                        child: Icon(
                          Icons.groups_outlined,
                          size: screenSize.width * (20 / widthScale),
                        ),
                      ),
                      Text(
                        '${widget.carona.vagas} Vagas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.height * (14 / 800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () async {
                      await _getRoute();
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DetalhesCarona(
                              isPedido: false,
                              route: route,
                              coordinates: [LatLng(widget.carona.origem[0], widget.carona.origem[1]),
                                            LatLng(widget.carona.dest[0], widget.carona.dest[1])
                              ],
                              carona: widget.carona,
                              veiculo: veiculo!,
                              motorista: motorista!,
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 250),
                        ),
                      );
                    },
                    child: Text('Detalhes'),
                  ),
                  FilledButton(
                    onPressed: () {
                      // Tela mensagem, passando ID do chat
                    },
                    child: Text('Chat'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
