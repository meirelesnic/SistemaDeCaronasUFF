import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:uff_caronas/view/custom_widgets/placa.dart';
import '../model/Services/mapa.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import '../model/Services/routeService.dart';
import '../model/modelos/Carona.dart';
import '../model/modelos/Usuario.dart';
import '../model/modelos/Veiculo.dart';

class DetalhesCarona extends StatefulWidget {
  final bool isPedido;
  final List<List<LatLng>>? pedidoRoutes;
  final List<double>? embarque;
  final List<double>? desembarque;
  final List<LatLng>? route;
  final List<LatLng> coordinates;
  final Carona carona;
  final Veiculo veiculo;
  final Usuario motorista;
  const DetalhesCarona({super.key, this.route, required this.coordinates, required this.carona, required this.veiculo, required this.motorista, required this.isPedido, this.pedidoRoutes, this.embarque, this.desembarque});

  @override
  State<DetalhesCarona> createState() => _DetalhesCaronaState();
}

class _DetalhesCaronaState extends State<DetalhesCarona> {
  late RouteService routeService;
  List<String> endEmbarque = ['Carregando',''];
  List<String> endDesembarque = ['Carregando',''];
  bool isLoading = true;
  @override
  void initState() {
    if(widget.isPedido){
      routeService = RouteService();
      getEnderecos();
      setState(() {
        
      });
    }
    super.initState();
  }

  void getEnderecos() async{
    endEmbarque = await routeService.getAddressFromLatLng(widget.embarque![0], widget.embarque![1]);
    endDesembarque = await routeService.getAddressFromLatLng(widget.desembarque![0], widget.desembarque![1]);
    setState(() {
      isLoading = false;
    });
  }

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
          SizedBox(
            height: screenSize.width * (280 / 360),
            child: Mapa(
              route: widget.isPedido ? widget.pedidoRoutes : [widget.route!],
              coordinates: widget.coordinates,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenSize.width * (13 / 360)),
                child: Column(
                  children: [
                    widget.isPedido ?
                    //Dados pasageiro na busca
                    Container(
                      //esse conatainer ficar carregando circular indicator enquanto o endereco é obtido
                      width: screenSize.width * (313 / 360),
                      padding: EdgeInsets.all(screenSize.width * (9 / 360)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child:
                       Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Meus Dados',
                                //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.bold
                                //   )
                                // ),
                                // const SizedBox(height: 7,),
                                Text('Embarque',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                Row(
                                  children: [
                                    isLoading ? 
                                    const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    :Container(),
                                    Expanded(
                                      child: Text(endEmbarque[0],
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(endEmbarque[1],
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                const SizedBox(height: 8,),
                                Text('Desembarque',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                Row(
                                  children: [
                                    isLoading ? 
                                    const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    :Container(),
                                    Expanded(
                                      child: Text(endDesembarque[0],
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(endDesembarque[1],
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ],
                            ),
                          ],
                        ),
                    )
                    :
                    Container(),
                    widget.isPedido ? SizedBox(height: 10,) : Container(),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.motorista.nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold
                                  )
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
                                        const Icon(Icons.star_rounded),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //ver reputacao ID
                                      },
                                      child: const Text('Ver reputação'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
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
                              const SizedBox(width: 15,),
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
                          const SizedBox(height: 7,),
                          Row(
                            children: [
                              Icon(
                                Icons.sports_score_rounded,
                                size: screenSize.width * (20 / 360),
                              ),
                              const SizedBox(width: 15,),
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
                          const SizedBox(height: 7,),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: screenSize.width * (20 / 360),
                              ),
                              const SizedBox(width: 15,),
                              Text(
                                '${widget.carona.data} - ${widget.carona.hora}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.height * (18 / 800),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10,),
                          //Veiculo
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: const EdgeInsets.all(18),
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
                                  const SizedBox(width: 10,),
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
                              const Icon(Icons.person_outline),
                              Text(' ${widget.carona.vagas}' ' Passageiros',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.height * (18 / 800),
                                  ),
                              ),
                              const Spacer(),
                              !widget.isPedido
                                  ? FilledButton(
                                      onPressed: () {
                                        // Tela mensagem, passando ID do chat
                                      },
                                      child: const Text('Chat'),
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
          widget.isPedido ? Padding(
            padding: EdgeInsets.symmetric(vertical: screenSize.height * (5/800)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * (80/360),
                  height: screenSize.height * (45/800),
                  child: FilledButton.tonal(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Voltar'),
                  ),
                ),
                SizedBox(width: 7,),
                SizedBox(
                  width: screenSize.width * (150/360),
                  height: screenSize.height * (45/800),
                  child: FilledButton(
                    onPressed: () {
                      //Metodo para participar da carona
                      // ou entar na lista de espera (autoaceitar false)
                    },
                    child: Text('Entrar na Carona'),
                  ),
                ),
              ],
            ),
          ) : Container()
        ],
      ),
    );
  }
}
