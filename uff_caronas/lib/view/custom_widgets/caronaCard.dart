import 'package:flutter/material.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';
import '../../model/modelos/Carona.dart';

class CaronaCard extends StatefulWidget {
  final Carona carona;

  const CaronaCard({Key? key, required this.carona}) : super(key: key);

  @override
  State<CaronaCard> createState() => _CaronaCardState();
}

class _CaronaCardState extends State<CaronaCard> {
  int widthScale = 500;
  Usuario? motorista;
  UsuarioController usuarioController = UsuarioController();

  @override
  void initState() {
    super.initState();
    _loadMotorista();
  }

  @override
  void didUpdateWidget(covariant CaronaCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.carona != oldWidget.carona) {
      _loadMotorista();
    }
  }

  Future<void> _loadMotorista() async {
    Usuario? usuario = await usuarioController.recuperarUsuario(widget.carona.motoristaId);
    setState(() {
      motorista = usuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: screenSize.width * (313 / 360),
        child: Container(
          padding: EdgeInsets.all(screenSize.width * (10 / 360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(//Avatar, nome motorista, estrelas
                children: [
                  CircleAvatar(
                    radius: screenSize.width * (25 / 360),
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(motorista!.fotoUrl),
                  ),
                  Container(width: screenSize.width * (12 / widthScale)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        motorista!.nome,
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
              //origem
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Text(
                    widget.carona.origemLocal,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.height * (14 / 800),
                    ),
                  ),
                ],
              ),
              //destino
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.sports_score_rounded,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Text(
                    widget.carona.origemDestino,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.height * (14 / 800),
                    ),
                  ),
                ],
              ),
              //data
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
              // veiculo e passageiros
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
                        widget.carona.veiculoId,
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
                        '${widget.carona.passageirosIds?.length} passageiros',
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
                    onPressed: () {
                      //Tela detalhes, passando ID da carona
                    },
                    child: Text('Detalhes'),
                  ),
                  FilledButton(
                    onPressed: () {
                      //Tela mensagem, passando ID do chat
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