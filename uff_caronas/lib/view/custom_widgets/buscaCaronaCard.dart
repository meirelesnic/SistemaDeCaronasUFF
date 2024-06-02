import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import '../../controller/VeiculoController.dart';
import 'package:intl/intl.dart';
import '../../model/modelos/CaronaInfo.dart';
import '../../model/modelos/Usuario.dart';
import '../../model/modelos/Veiculo.dart';

class BuscaCaronaCard extends StatefulWidget {
  final Carona carona;
  final CaronaInfo info;

  const BuscaCaronaCard({super.key, required this.carona, required this.info});

  @override
  State<BuscaCaronaCard> createState() => _BuscaCaronaCardState();
}

class _BuscaCaronaCardState extends State<BuscaCaronaCard> {
  String horaChegada = '';

  @override
  void initState() {
    horaChegada = addMinutesToTimeString(widget.carona.hora, widget.info.routeDuration);
    super.initState();
  }

  String addMinutesToTimeString(String time, int minutes) {
    DateTime timeParsed = DateFormat.Hm().parse(time);
    timeParsed = timeParsed.add(Duration(minutes: minutes));
    String newTimeString = DateFormat.Hm().format(timeParsed);
    setState(() {
      
    });
    
    return newTimeString;
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
          padding: EdgeInsets.all(screenSize.width * (15 / 360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize.height * (3/800),
                      ),
                      Text(widget.carona.hora,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: screenSize.width * (52/360) - screenSize.width * (28/360)),
                      Text(horaChegada,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenSize.width * (10/360)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                     
                      Column(
                        children: [
                           SizedBox(
                            height: screenSize.height * (5/800),
                          ),
                          Container(
                            width: screenSize.width * (12 / 360),
                            height: screenSize.width * (12 / 360),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Container(
                            width: screenSize.width * (3 / 360),
                            height: screenSize.width * (40 / 360),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Container(
                            width: screenSize.width * (12 / 360),
                            height: screenSize.width * (12 / 360),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.6,
                              ),
                              color: Theme.of(context).colorScheme.secondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width * (10/360)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.carona.origemLocal,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.directions_walk_rounded,
                              size: screenSize.width * (14 / 360),
                            ),
                            Text('${widget.info.walkingDistanceStart} Km',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.width * (17 / 360)), // Espaço proporcional ao conteúdo entre os textos
                        Text(widget.carona.origemDestino,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.directions_walk_rounded,
                              size: screenSize.width * (14 / 360),
                            ),
                            Text('${widget.info.walkingDistanceEnd} Km',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * (15/800)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_car_filled_outlined,
                        size: screenSize.width * (20/ 360),
                      ),
                      SizedBox(width: screenSize.width * (4/360)),
                      Text(
                        veiculo != null ? '${veiculo.marca} ${veiculo.modelo}' : 'Veículo desconhecido',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.people_outline,
                        size: screenSize.width * (20 / 360),
                      ),
                      const SizedBox(width: 4),
                      Text('${widget.carona.vagas} Vagas',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * (15/800)
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: screenSize.width * (20 / 360),
                    backgroundColor: Colors.blue,
                    backgroundImage: motorista?.fotoUrl != null
                        ? NetworkImage(motorista!.fotoUrl)
                        : null,
                    child: motorista?.fotoUrl == null
                        ? const Icon(Icons.person, size: 30)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(motorista?.nome ?? '',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      Text('Motorista',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '4,8',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenSize.height * (13 / 800),
                        ),
                      ),
                      Icon(Icons.star_rate_rounded,
                        size: screenSize.width * (18 / 360),
                      ),
                    ],
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
