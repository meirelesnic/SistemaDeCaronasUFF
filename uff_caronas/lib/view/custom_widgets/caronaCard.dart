import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:uff_caronas/controller/CaronaController.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/DAO/AvaliacaoDAO.dart';
import 'package:uff_caronas/model/DAO/ChatGrupoDAO.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/model/modelos/chatGrupo.dart';
import 'package:uff_caronas/view/detalhesCarona.dart';
import 'package:uff_caronas/view/fazerAvaliacao.dart';
import 'package:uff_caronas/view/login.dart';
import '../../controller/VeiculoController.dart';


import '../../model/Services/routeService.dart';
import '../../model/modelos/Usuario.dart';
import '../../model/modelos/Veiculo.dart';
import '../chatMessages.dart';

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
  final ChatGrupoDAO _chatGrupoDAO = ChatGrupoDAO();
  bool passouData = false;

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

 

  Future<ChatGrupo?> _getChat() async {
    ChatGrupo? chat = await _chatGrupoDAO.getChatGrupoById(widget.carona.id);
    return chat;
  }

  Future<String?> _getPassageiros(List<String> passageirosIds) async {
    UsuarioController usuarioController = UsuarioController();
    String fetchedPassageiros = '';
    for (String id in passageirosIds) {
    Usuario? usuario = await usuarioController.recuperarUsuario(id);
      if (usuario != null) {
        fetchedPassageiros += '${usuario.nome.split(' ').first}, ';
      }
    }
     if (fetchedPassageiros.isNotEmpty) {
      fetchedPassageiros = fetchedPassageiros.substring(0, fetchedPassageiros.length - 2);
    }
    return fetchedPassageiros;
  }

  bool hasPassed(String date, String time) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

    TimeOfDay parsedTime = TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );

    DateTime combinedDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );
    DateTime now = DateTime.now();
    return combinedDateTime.isBefore(now);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
  future: Future.wait([
    UsuarioController().recuperarUsuario(widget.carona.motoristaId),
    VeiculoController().recuperarVeiculoDoc(widget.carona.veiculoId) ?? Future.value(null),
    AvaliacaoDAO.getMedia(widget.carona.motoristaId, true),
    AvaliacaoDAO.usuarioAvaliouCarona(user!.id, widget.carona.id)
  ]),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Container(width: 15); // Mostra um indicador de progresso enquanto os dados estão sendo carregados
    } else if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}'); // Exibe uma mensagem de erro se houver algum erro
    } else {
      Usuario? motorista = snapshot.data?[0] as Usuario?;
      Veiculo? veiculo = snapshot.data?[1] as Veiculo?;
      double mediaMotorista = snapshot.data?[2] as double? ?? 0.0; // Obtém a média do motorista
      bool jaAvaliou = snapshot.data?[3] as bool? ?? false;
      return _buildCaronaCard(context, motorista, veiculo, mediaMotorista, jaAvaliou); // Constrói o widget do CaronaCard com os dados do motorista, veículo e média
    }
  },
);
  }

  Widget _buildCaronaCard(BuildContext context, Usuario? motorista, Veiculo? veiculo, double media, bool jaAvaliou) {
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
                            '$media',
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
                      print('n passageiros ${widget.carona.passageirosIds!.length}');
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
                    onPressed: () async {
                      ChatGrupo? chat = await _getChat();
                      String? passageiros = await _getPassageiros(chat!.membersId);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ChatMessages(chat: chat, nomeUsuarios: passageiros!,);
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 250),
                        ),
                      );
                    },
                    child: Text('Chat'),
                  ),
                ],
              ),
                // D: A data atual passou da data especificada.
                // P: O motoristaid é igual ao user_id.
                // L: A lista de passageiros não é vazia.
              //(¬P∧D)∨(P∧L∧D)
              
              !jaAvaliou && ((widget.carona.motoristaId != user!.id && hasPassed(widget.carona.data, widget.carona.hora)) || (widget.carona.motoristaId == user!.id && widget.carona.passageirosIds!.isNotEmpty && hasPassed(widget.carona.data, widget.carona.hora))) ?
              OutlinedButton(
                onPressed: () {
                   Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return FazerAvaliacao(
                              isMotorista: widget.carona.motoristaId != user!.id,
                              carona: widget.carona,
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 250),
                        ),
                      );
                },
                child: const Text('Fazer Avaliação'),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
