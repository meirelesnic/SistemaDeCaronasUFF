import 'package:flutter/material.dart';
import 'package:uff_caronas/view/login.dart';
import '../controller/VeiculoController.dart';
import '../model/DAO/VeiculoDAO.dart';
import '../model/modelos/Veiculo.dart';
import 'meusVeiculos.dart';

class AdicionarVeiculo extends StatefulWidget {
  @override
  State<AdicionarVeiculo> createState() => _AdicionarVeiculoState();
}

class _AdicionarVeiculoState extends State<AdicionarVeiculo> {
  late TextEditingController _placaController;
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;

  String _selectedBrand = '';
  final List<String> _brands = [
    'Fiat',
    'Volkswagen',
    'Chevrolet',
    'Ford',
    'Toyota',
    'Hyundai',
    'Honda',
    'Renault',
    'Nissan',
    'Jeep',
    'Outra',
  ];

  String _selectedColor = '';
  final List<String> _colors = [
    'azul',
    'amarelo',
    'branco',
    'cinza',
    'laranja',
    'preto',
    'verde',
    'vermelho'
  ];

  @override
  void initState() {
    super.initState();
    _placaController = TextEditingController();
    _brandController = TextEditingController();
    _modelController = TextEditingController();
    _yearController = TextEditingController();
    _selectedBrand = _brands[0];
    _selectedColor = _colors[0]; // Define a cor padrão como a primeira da lista
  }

  bool _verificarVeiculo(VeiculoController vc) {
    if (!vc.validaPlaca(_placaController.text)) return false;
    try {
      if (!vc.validaAno(int.parse(_yearController.text))) return false;
    } catch (e) {
      //controller null
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool invalido = false;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    height: screenSize.height * (130.0 / 800.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
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
                      ),
                    ),
                    child: Container(
                      width: screenSize.width,
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * (25 / 360)),
                      child: Text(
                        "Adicionar Veículo",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: screenSize.height * (33 / 800)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenSize.height * (3 / 5),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cor: ",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenSize.height *
                                                  (20 / 800)),
                                        ),
                                        DropdownButton<String>(
                                          value: _selectedColor,
                                          items: _colors.map((color) {
                                            return DropdownMenuItem<String>(
                                              value: color,
                                              child: Text(color),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedColor = newValue!;
                                            });
                                          },
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenSize.height *
                                                  (20 / 800)),
                                          alignment: Alignment.center,
                                        ),
                                      ]),
                                  Row(
                                    children: [
                                      Text(
                                        "Marca: ",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                screenSize.height * (20 / 800)),
                                      ),
                                      DropdownButton<String>(
                                        value: _selectedBrand,
                                        items: _brands.map((brand) {
                                          return DropdownMenuItem<String>(
                                            value: brand,
                                            child: Text(brand),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedBrand = newValue!;
                                            if (newValue == 'Outra')
                                              _brandController.clear();
                                          });
                                        },
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                screenSize.height * (20 / 800)),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    Text(
                                      "Modelo: ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              screenSize.height * (20 / 800)),
                                    ),
                                    SizedBox(
                                        width: screenSize.width * (0.3),
                                        child: TextField(
                                          controller: _modelController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenSize.height *
                                                  (20 / 800)),
                                          textAlign: TextAlign.start,
                                        ))
                                  ]),
                                  Row(children: [
                                    Text(
                                      "Placa: ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              screenSize.height * (20 / 800)),
                                    ),
                                    SizedBox(
                                        width: screenSize.width * (0.3),
                                        child: TextField(
                                          maxLength: 7,
                                          controller: _placaController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenSize.height *
                                                  (20 / 800)),
                                          textAlign: TextAlign.start,
                                        ))
                                  ]),
                                  Row(children: [
                                    Text(
                                      "Ano: ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              screenSize.height * (20 / 800)),
                                    ),
                                    SizedBox(
                                        width: screenSize.width * (0.3),
                                        child: TextField(
                                          maxLength: 4,
                                          keyboardType: TextInputType.number,
                                          controller: _yearController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: screenSize.height *
                                                  (20 / 800)),
                                          textAlign: TextAlign.start,
                                        ))
                                  ]),
                                  // Aqui você pode adicionar os campos restantes conforme necessário
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    var autenticacaoVeiculo =
                                        VeiculoController();
                                    if (_verificarVeiculo(
                                        autenticacaoVeiculo)) {
                                      print(1);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                                'Deseja cadastrar o seguinte veículo:\nmodelo: ${_modelController.text}\nmarca: ${_brandController.text}\ncor: ${_selectedColor}\nano: ${int.parse(_yearController.text)}\nplaca: ${_placaController.text}.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Não'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  autenticacaoVeiculo
                                                      .salvarVeiculo(
                                                          _modelController.text,
                                                          _brandController.text,
                                                          _selectedColor,
                                                          int.parse(
                                                              _yearController
                                                                  .text),
                                                          user!.id,
                                                          _placaController
                                                              .text);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Sim'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      /*
                                    // Cria um novo veículo com as informações dos campos de texto
                                    _autenticacaoVeiculo.salvarVeiculo(
                                        _modelController.text,
                                        _brandController.text,
                                        _selectedColor,
                                        int.parse(_yearController.text),
                                        user!.id,
                                        _placaController.text);*/
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Campo incorreto"),
                                            content: Text(
                                                'Não foi possível confirmar, pois algum dos campos foi preenchido incorretamente.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      ;
                                    }
                                    // Adiciona o novo veículo ao banco de dados
                                    //VeiculoController().adicionarVeiculo(novoVeiculo);
                                    // Após adicionar, navega de volta para a tela MeusVeiculos
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Text(
                                    'Confirmar',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            )));
  }
}
