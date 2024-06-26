import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uff_caronas/controller/CaronaController.dart';
import 'package:uff_caronas/model/DAO/CaronaDAO.dart';
import 'package:uff_caronas/view/custom_widgets/veiculoData.dart';
import 'login.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:uff_caronas/model/DAO/VeiculoDAO.dart';
import 'package:uff_caronas/model/JSONmodel/infoBuscaPlaces.dart';
import 'package:uff_caronas/model/modelos/Veiculo.dart';

import 'mainScreen.dart';

class OferecerCarona extends StatefulWidget {
  const OferecerCarona({super.key});

  @override
  State<OferecerCarona> createState() => _OferecerCaronaState();
}

class _OferecerCaronaState extends State<OferecerCarona> {
  TextEditingController origemLocal = TextEditingController();
  TextEditingController destinoLocal = TextEditingController();
  TextEditingController dataSelecionada = TextEditingController();
  TextEditingController horaSelecionada = TextEditingController();

  FocusNode origemFocus = FocusNode();
  FocusNode destinoFocus = FocusNode();

  List<Veiculo> veiculos = [];

  List<InfoBuscaPlaces> enderecos = [];
  List<double> origemCoord = [];
  List<double> destinoCoord = [];

  bool dateVazio = true;
  bool horaVazio = true;

  bool autoaceitar = false;
  final List<bool> _acentosBool = List<bool>.filled(6, false);

  int quantAcentos = 0;
  Veiculo? selectedVeiculo;

  String dataCarona = '';
  String horaCarona = '';

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  void initState() {
    _carregarVeiculos();
    origemCoord = [0, 0];
    destinoCoord = [0, 0];
    super.initState();
  }

  Future<void> _carregarVeiculos() async {
    veiculos = await VeiculoDAO().recuperarVeiculosPorUsuario(user!.id);
    setState(() {});
    print(veiculos);
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

  bool _isFormComplete() {
    return origemLocal.text.isNotEmpty &&
        destinoLocal.text.isNotEmpty &&
        origemCoord[0] != 0 &&
        origemCoord[1] != 0 &&
        destinoCoord[0] != 0 &&
        destinoCoord[1] != 0 &&
        //!dateVazio &&
        //!horaVazio &&
        quantAcentos > 0 &&
        selectedVeiculo != null;
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
            children: [
              Container(
                padding: EdgeInsets.all(screenSize.width * (28 / 360)),
                width: double.infinity,
                height: screenSize.height * (305 / 800),
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
                      'Oferecer Carona',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.background),
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
                                  enderecos.clear();
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
                                enderecos.clear();
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
                                          buttonText: 'Selecionar localização',
                                          onPicked: (pickedData) {
                                            origemLocal.text =
                                                pickedData.addressName;
                                            LatLong coord = pickedData.latLong;
                                            origemCoord[0] = coord.latitude;
                                            origemCoord[1] = coord.longitude;
                                            Navigator.of(context).pop();
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
                                  enderecos.clear();
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
                                enderecos.clear();
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
                                          buttonText: 'Selecionar localização',
                                          onPicked: (pickedData) {
                                            destinoLocal.text =
                                                pickedData.addressName;
                                            LatLong coord = pickedData.latLong;
                                            destinoCoord[0] = coord.latitude;
                                            destinoCoord[1] = coord.longitude;
                                            Navigator.of(context).pop();
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
                  ],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  thickness: screenSize.width * (8 / 360),
                  trackVisibility: true,
                  thumbVisibility: true,
                  radius: Radius.circular(5),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenSize.width * (28 / 360)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * (7 / 800)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: 2 * screenSize.width / 5),
                                    child: Text(
                                      getDataCalendario(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
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
                              )),
                          Text(
                            'Hora',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenSize.height * (7 / 800)),
                                  child: Text(
                                    getHorario(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showTimePicker();
                                },
                                icon: Icon(Icons.alarm),
                                label: Text('Selecionar'),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * (11 / 800)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Autoaceitar?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                  Switch(
                                    thumbIcon: thumbIcon,
                                    value: autoaceitar,
                                    onChanged: (bool value) {
                                      setState(() {
                                        autoaceitar = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Veículo',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<Veiculo>(
                                value: null,
                                hint: Text('Selecione'),
                                onChanged: (Veiculo? selected) {
                                  selectedVeiculo = selected;
                                  setState(() {});
                                },
                                items: veiculos.map((Veiculo veiculo) {
                                  return DropdownMenuItem<Veiculo>(
                                    value: veiculo,
                                    child: Text(
                                        '${veiculo.marca} ${veiculo.modelo} (${veiculo.placa})'),
                                  );
                                }).toList(),
                              ),
                              selectedVeiculo != null
                                  ? VeiculoData(veiculo: selectedVeiculo!)
                                  : Container(),
                            ],
                          ),
                          Text(
                            'Vagas',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          ToggleButtons(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            fillColor: Theme.of(context).colorScheme.primary,
                            selectedColor: Colors.white,
                            isSelected: _acentosBool,
                            children: const [
                              Text('1'),
                              Text('2'),
                              Text('3'),
                              Text('4'),
                              Text('5'),
                              Text('6'),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                // The button that is tapped is set to true, and the others to false.
                                for (int i = 0; i < _acentosBool.length; i++) {
                                  _acentosBool[i] = i == index;
                                  quantAcentos = index + 1;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: screenSize.width * (254 / 360),
                  height: screenSize.height * (45 / 800),
                  child: FilledButton(
                    onPressed: () {
                      if (_isFormComplete()) {
                        CaronaController caronaController = CaronaController();

                        caronaController.salvarCarona(
                          origemCoord,
                          destinoCoord,
                          origemLocal.text,
                          destinoLocal.text,
                          dataCarona,
                          horaCarona,
                          autoaceitar,
                          selectedVeiculo!.id,
                          quantAcentos,
                          user!.id,
                          [],
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Carona Registrada'),
                            duration: Duration(seconds: 5),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Por favor, preencha todos os campos obrigatórios.'),
                              duration: Duration(seconds: 5),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error),
                        );
                      }
                    },
                    child: Text('Adicionar Carona'),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: screenSize.width * (28 / 360),
            top: origemFocus.hasFocus
                ? screenSize.height * (150 / 800)
                : screenSize.height * (235 / 800),
            child: Container(
              color: Colors.white,
              child: SizedBox(
                width: screenSize.width * (254 / 360),
                child: Column(
                  children: [
                    ...enderecos
                        .map((e) => ListTile(
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
                                  });
                                } else {
                                  destinoLocal.text = e.properties?.name ?? '';
                                  //destinoFocus.dispose();
                                  enderecos.clear();
                                  setState(() {
                                    var coord = e.geometry!.coordinates!;
                                    destinoCoord[0] = coord[1];
                                    destinoCoord[1] = coord[0];
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
