import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:uff_caronas/view/buscaCarona.dart';

import '../model/JSONmodel/infoBuscaPlaces.dart';
import '../model/Services/mapa.dart';
import '../model/Services/routeService.dart';

class PedirCarona extends StatefulWidget {
  const PedirCarona({super.key});

  @override
  State<PedirCarona> createState() => _PedirCaronaState();
}

class _PedirCaronaState extends State<PedirCarona> {
  TextEditingController origemLocal = TextEditingController();
  TextEditingController destinoLocal = TextEditingController();
  TextEditingController dataSelecionada = TextEditingController();
  TextEditingController horaSelecionada = TextEditingController();

  FocusNode origemFocus = FocusNode();
  FocusNode destinoFocus = FocusNode();

  List<InfoBuscaPlaces> enderecos = [];
  List<double> origemCoord = [];
  List<double> destinoCoord = [];
  List<LatLng>? route;

  bool dateVazio = true;
  bool horaVazio = true;

  bool origem = false;
  bool destino = false;

  String dataCarona = '';
  String horaCarona = '';

  late RouteService routeService;

  @override
  void initState() {
    origemCoord = [0, 0];
    destinoCoord = [0, 0];
    routeService = RouteService();
    super.initState();
  }

  String getDataCalendario() {
    DateTime hoje = DateTime.now();
    if (dateVazio) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(hoje);
      dataCarona = formattedDate;
      return "Hoje, $formattedDate";
    }
    return "$dataCarona";
  }

  void updateDate(DateTime? dt) {
    if (dt == null) {
      return;
    }
    setState(() {
      dateVazio = false;
      dataCarona = DateFormat('dd/MM/yyyy').format(dt);
      ;
    });
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2028))
        .then((value) => updateDate(value));
  }

  String getHorario() {
    if (horaVazio) {
      DateTime hoje = DateTime.now();
      String formattedTime = DateFormat('HH:mm').format(hoje);
      horaCarona = formattedTime;
      return formattedTime;
    }
    return "$horaCarona";
  }

  void updateHora(TimeOfDay? dt) {
    if (dt == null) {
      return;
    }
    setState(() {
      horaVazio = false;
      horaCarona = dt.toString().split('(')[1].replaceAll(')', '');
    });
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => updateHora(value));
  }

  void autoCompletarLocal(String val) async {
    await buscaEnderecoAPI(val).then((value) {
      setState(() {
        enderecos = value;
      });
    });
  }

  Future<List<InfoBuscaPlaces>> buscaEnderecoAPI(String endereco) async {
    Response response = await Dio().get('https://photon.komoot.io/api/',
        queryParameters: {
          "q": endereco,
          "limit": 4,
          "bbox": '-44.4289,-23.3575,-40.7499,-20.7640'
        }); //https://github.com/komoot/photon documentação

    final json = response.data;
    return (json['features'] as List)
        .map((e) => InfoBuscaPlaces.fromJson(e))
        .toList();
  }

  Future<void> checkOrigemDestinoRota() async {
    if (origem && destino) {
      List<LatLng> result = await routeService.getRouteLatLng(
          origemCoord[0], origemCoord[1], destinoCoord[0], destinoCoord[1]);
      setState(() {
        route = result;
      });
    } else {
      setState(() {
        route = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.background,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(screenSize.width * (28 / 360)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pedir Carona',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.background),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * (8 / 800)),
                        child: Text('De',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenSize.width * (254 / 360),
                            child: TextField(
                              //Buscar Origem
                              decoration: InputDecoration(
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    origemLocal.clear();
                                    origemCoord = [0, 0];
                                    origem = false;
                                    enderecos.clear();
                                    checkOrigemDestinoRota();
                                    setState(() {});
                                  },
                                ),
                                hintText: 'Buscar',
                                filled: true,
                              ),
                              controller: origemLocal,
                              focusNode: origemFocus,
                              onChanged: (String value) {
                                if (value != '') {
                                  autoCompletarLocal(value);
                                } else {
                                  origemLocal.clear();
                                  origemCoord = [0, 0];
                                  origem = false;
                                  enderecos.clear();
                                  checkOrigemDestinoRota();
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                        height: 1.5 *
                                            screenSize
                                                .width, // Defina a altura que você deseja
                                        width: screenSize
                                            .width, // Defina a largura que você deseja
                                        child: OpenStreetMapSearchAndPick(
                                            //center: LatLong(23, 89),
                                            buttonColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            buttonText:
                                                'Selecionar localização',
                                            onPicked: (pickedData) {
                                              origemLocal.text =
                                                  pickedData.addressName;
                                              LatLong coord =
                                                  pickedData.latLong;
                                              origemCoord[0] = coord.latitude;
                                              origemCoord[1] = coord.longitude;
                                              origem = true;
                                              Navigator.of(context).pop();
                                              checkOrigemDestinoRota();
                                              setState(() {});
                                            })),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.map_outlined),
                            color: Theme.of(context).colorScheme.background,
                          )
                        ],
                      ),
                      // ...enderecos
                      //   .map((e) => ListTile(
                      //     leading: Icon(Icons.place),
                      //     title: Text("${e.properties?.name ?? ''}"),
                      //     subtitle: Text("${e.properties?.locality ?? ''} - ${e.properties?.city ?? ''}"),
                      //     )).toList(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * (8 / 800)),
                        child: Text('Para',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenSize.width * (254 / 360),
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    destinoLocal.clear();
                                    destinoCoord = [0, 0];
                                    destino = false;
                                    enderecos.clear();
                                    checkOrigemDestinoRota();
                                    setState(() {});
                                  },
                                ),
                                hintText: 'Buscar',
                                filled: true,
                              ),
                              controller: destinoLocal,
                              focusNode: destinoFocus,
                              onChanged: (String value) {
                                if (value != '') {
                                  autoCompletarLocal(value);
                                } else {
                                  destinoLocal.clear();
                                  destinoCoord = [0, 0];
                                  destino = false;
                                  enderecos.clear();
                                  checkOrigemDestinoRota();
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                        height: 1.5 *
                                            screenSize
                                                .width, // Defina a altura que você deseja
                                        width: screenSize
                                            .width, // Defina a largura que você deseja
                                        child: OpenStreetMapSearchAndPick(
                                            //center: LatLong(23, 89),
                                            buttonColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            buttonText:
                                                'Selecionar localização',
                                            onPicked: (pickedData) {
                                              destinoLocal.text =
                                                  pickedData.addressName;
                                              LatLong coord =
                                                  pickedData.latLong;
                                              destinoCoord[0] = coord.latitude;
                                              destinoCoord[1] = coord.longitude;
                                              destino = true;
                                              Navigator.of(context).pop();
                                              checkOrigemDestinoRota();
                                              setState(() {});
                                            })),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.map_outlined),
                            color: Theme.of(context).colorScheme.background,
                          )
                        ],
                      ),
                      //Text('Coordenadas'),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * (28 / 360)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 2 * screenSize.width / 5),
                                  child: Text(
                                    getDataCalendario(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _showDatePicker();
                                  },
                                  icon: Icon(Icons.today_outlined),
                                  label: Text('Selecionar'),
                                )
                              ],
                            ),
                            Text(
                              'Hora',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getHorario(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _showTimePicker();
                                  },
                                  icon: Icon(Icons.alarm),
                                  label: Text('Selecionar'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        height: screenSize.height * (215 / 800),
                        child: Mapa(
                          route: route == null ? [] : [route!],
                          coordinates: [
                            LatLng(origemCoord[0], origemCoord[1]),
                            LatLng(destinoCoord[0], destinoCoord[1])
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * (5 / 800)),
                  child: SizedBox(
                    width: screenSize.width * (254 / 360),
                    height: screenSize.height * (45 / 800),
                    child: FilledButton(
                      onPressed: () {
                        if (origem && destino) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return BuscaCarona(
                                  origemCoord: origemCoord,
                                  destinoCoord: destinoCoord,
                                  dataCarona: dataCarona,
                                  horaCarona: horaCarona,
                                  nomeDestino: destinoLocal.text,
                                  nomeOrigem: origemLocal.text,
                                );
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 250),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Por favor, selecione os locais'),
                              duration: Duration(seconds: 4),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                      },
                      child: Text('Buscar Caronas'),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              left: screenSize.width * (28 / 360),
              top: origemFocus.hasFocus
                  ? screenSize.height * (145 / 800)
                  : screenSize.height * (230 / 800),
              child: Container(
                color: Colors.white,
                child: SizedBox(
                  width: screenSize.width * (254 / 360),
                  child: Column(
                    children: [
                      ...enderecos.map((e) => ListTile(
                            title: Text(
                              "${e.properties?.name ?? ''}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            subtitle: Text(
                                "${e.properties?.locality ?? ''} - ${e.properties?.city ?? ''}"),
                            onTap: () {
                              if (origemFocus.hasFocus) {
                                //origemLocal.clear();
                                origemLocal.text = e.properties?.name ?? '';
                                //origemFocus.dispose();
                                enderecos.clear();
                                setState(() {
                                  var coord = e.geometry!.coordinates!;
                                  origemCoord[0] = coord[1];
                                  origemCoord[1] = coord[0];
                                  origem = true;
                                  checkOrigemDestinoRota();
                                });
                              } else {
                                destinoLocal.text = e.properties?.name ?? '';
                                //destinoFocus.dispose();
                                enderecos.clear();
                                setState(() {
                                  var coord = e.geometry!.coordinates!;
                                  destinoCoord[0] = coord[1];
                                  destinoCoord[1] = coord[0];
                                  destino = true;
                                  checkOrigemDestinoRota();
                                });
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
