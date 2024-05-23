import 'package:flutter/material.dart';

class EditarVeiculo extends StatefulWidget {
  const EditarVeiculo({super.key});

  @override
  State<EditarVeiculo> createState() => _EditarVeiculoState();
}

class _EditarVeiculoState extends State<EditarVeiculo> {
  bool isEditingvehicle = false;
  TextEditingController _veiculoController =
      TextEditingController(text: "LTZ1244");
  bool isEditingBrand = false;
  bool isEditingModel = false;
  bool isEditingYear = false;
  TextEditingController _brandController =
      TextEditingController(text: "Chevrolet");
  TextEditingController _modelController =
      TextEditingController(text: "Prisma");
  TextEditingController _yearController = TextEditingController(text: "2016");

  String _selectedColor = 'vermelho'; // Cor selecionada inicialmente
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
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                        'Editar veículo',
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Placa: ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenSize.height *
                                                    (20 / 800)),
                                          ),
                                          isEditingvehicle
                                              ? // condicional para editar perfil
                                              // Editando

                                              Row(children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                          (0.3),
                                                      child: TextField(
                                                        controller:
                                                            _veiculoController,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: screenSize
                                                                    .height *
                                                                (20 / 800)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      )),
                                                  const SizedBox(width: 5),
                                                  GestureDetector(
                                                      child: const Icon(
                                                          Icons.check_sharp),
                                                      onTap: () {
                                                        setState(() {
                                                          isEditingvehicle =
                                                              !isEditingvehicle;
                                                          // UsuarioController().editarUsuario(
                                                          //     user!.id, _userNameController.text);
                                                        });
                                                      })
                                                ])

                                              // Nâo está editando
                                              : Row(
                                                  children: [
                                                    Text(
                                                      _veiculoController.text,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: screenSize
                                                                  .height *
                                                              (20 / 800)),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    GestureDetector(
                                                        child: const Icon(Icons
                                                            .edit_outlined),
                                                        onTap: () {
                                                          setState(() {
                                                            isEditingvehicle =
                                                                !isEditingvehicle;
                                                          });
                                                        })
                                                  ],
                                                ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Image.asset(
                                          "image/car_icons/carro_$_selectedColor.png",
                                          width: screenSize.width * (1 / 6),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    ],
                                  ),
                                  // Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         "Marca: ",
                                  //         style: TextStyle(
                                  //             color: Theme.of(context)
                                  //                 .colorScheme
                                  //                 .primary,
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: screenSize.height *
                                  //                 (20 / 800)),
                                  //       ),
                                  //     ]),

                                  // Campo de Marca
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      isEditingBrand
                                          ? // condicional para editar
                                          // Editando

                                          Row(children: [
                                              SizedBox(
                                                  width:
                                                      screenSize.width * (0.3),
                                                  child: TextField(
                                                    controller:
                                                        _brandController,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            screenSize.height *
                                                                (20 / 800)),
                                                    textAlign: TextAlign.start,
                                                  )),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                  child: const Icon(
                                                      Icons.check_sharp),
                                                  onTap: () {
                                                    setState(() {
                                                      isEditingBrand =
                                                          !isEditingBrand;
                                                    });
                                                  })
                                            ])

                                          // Nâo está editando
                                          : Row(
                                              children: [
                                                Text(
                                                  _brandController.text,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          screenSize.height *
                                                              (20 / 800)),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                    child: const Icon(
                                                        Icons.edit_outlined),
                                                    onTap: () {
                                                      setState(() {
                                                        isEditingBrand =
                                                            !isEditingBrand;
                                                      });
                                                    })
                                              ],
                                            ),
                                    ],
                                  ),
                                  // Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         "Modelo: ",
                                  //         style: TextStyle(
                                  //             color: Theme.of(context)
                                  //                 .colorScheme
                                  //                 .primary,
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: screenSize.height *
                                  //                 (20 / 800)),
                                  //       ),
                                  //     ]),
                                  // Campo de Modelo
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                                      isEditingModel
                                          ? // condicional para editar
                                          // Editando

                                          Row(children: [
                                              SizedBox(
                                                  width:
                                                      screenSize.width * (0.3),
                                                  child: TextField(
                                                    controller:
                                                        _modelController,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            screenSize.height *
                                                                (20 / 800)),
                                                    textAlign: TextAlign.start,
                                                  )),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                  child: const Icon(
                                                      Icons.check_sharp),
                                                  onTap: () {
                                                    setState(() {
                                                      isEditingModel =
                                                          !isEditingModel;
                                                    });
                                                  })
                                            ])

                                          // Nâo está editando
                                          : Row(
                                              children: [
                                                Text(
                                                  _modelController.text,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          screenSize.height *
                                                              (20 / 800)),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                    child: const Icon(
                                                        Icons.edit_outlined),
                                                    onTap: () {
                                                      setState(() {
                                                        isEditingModel =
                                                            !isEditingModel;
                                                      });
                                                    })
                                              ],
                                            ),
                                    ],
                                  ),
                                  // Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         "Ano: ",
                                  //         style: TextStyle(
                                  //             color: Theme.of(context)
                                  //                 .colorScheme
                                  //                 .primary,
                                  //             fontWeight: FontWeight.w500,
                                  //             fontSize: screenSize.height *
                                  //                 (20 / 800)),
                                  //       ),
                                  //     ]),
                                  // Campo de ano
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
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
                                      isEditingYear
                                          ? // condicional para editar
                                          // Editando

                                          Row(children: [
                                              SizedBox(
                                                  width:
                                                      screenSize.width * (0.3),
                                                  child: TextField(
                                                    controller: _yearController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            screenSize.height *
                                                                (20 / 800)),
                                                    textAlign: TextAlign.start,
                                                  )),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                  child: const Icon(
                                                      Icons.check_sharp),
                                                  onTap: () {
                                                    setState(() {
                                                      isEditingYear =
                                                          !isEditingYear;
                                                    });
                                                  })
                                            ])

                                          // Nâo está editando
                                          : Row(
                                              children: [
                                                Text(
                                                  _yearController.text,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          screenSize.height *
                                                              (20 / 800)),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                    child: const Icon(
                                                        Icons.edit_outlined),
                                                    onTap: () {
                                                      setState(() {
                                                        isEditingYear =
                                                            !isEditingYear;
                                                      });
                                                    })
                                              ],
                                            ),
                                    ],
                                  ),
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                  child: Text('Cancelar'),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    print('Salvar pressionado');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  child: Text(
                                    'Salvar',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
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
