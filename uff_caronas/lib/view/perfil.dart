import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';
import 'package:uff_caronas/view/fazerAvaliacao.dart';
import 'package:uff_caronas/view/login.dart';
import 'package:uff_caronas/view/pedidoArmazenado.dart';
import 'package:uff_caronas/view/meusVeiculos.dart';
import 'package:uff_caronas/view/verAvaliacao.dart';

import '../model/Services/googleAuthenticator.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool isEditingProfile = false;
  TextEditingController _userNameController =
  TextEditingController(text: user!.nome);
  String nomeAntigo = user!.nome;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: screenSize.height * (245 / 800.0),
              margin: const EdgeInsets.symmetric(horizontal: 10),
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
              child: SizedBox(
                  width: screenSize.width,
                  //alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * (12 / 360)),
                        child: CircleAvatar(
                          radius: screenSize.width * (61 / 360),
                          backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage(user!.fotoUrl),
                        ),
                      ),
                      isEditingProfile
                          ? // condicional para editar perfil
                      // Editando
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: screenSize.width * (0.5),
                                child: TextField(
                                  controller: _userNameController,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      screenSize.height * (25 / 800)),
                                  textAlign: TextAlign.center,
                                )),
                            const SizedBox(width: 5),
                            InkWell(
                                child: const Icon(Icons.cancel_outlined),
                                onTap: () {
                                  setState(() {
                                    isEditingProfile = !isEditingProfile;
                                    _userNameController.text = nomeAntigo;
                                  });
                                }),
                            const SizedBox(width: 5),
                            InkWell(
                                child: const Icon(Icons.check_sharp),
                                onTap: () {
                                  setState(() {
                                    isEditingProfile = !isEditingProfile;
                                    UsuarioController().editarUsuario(
                                        user!.id,
                                        _userNameController.text);
                                    user?.nome = _userNameController.text;
                                  });
                                })
                          ])
                      // Não está editando
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _userNameController.text,
                            style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: screenSize.height * (25 / 800)),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                              child: const Icon(Icons.edit_outlined),
                              onTap: () {
                                setState(() {
                                  isEditingProfile = !isEditingProfile;
                                });
                              })
                        ],
                      ),
                      Text(
                        user!.email,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: screenSize.height * (15 / 800)),
                      ),
                    ],
                  )),
            ),
          ),
          //Avaliacao
          Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * (15 / 800)),
              padding: EdgeInsets.all(screenSize.height * (15 / 800)),
              width: screenSize.width * (313 / 360),
              height: screenSize.height * (169 / 800),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suas Avaliações',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: screenSize.height * (22 / 800)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Passageiro',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (15 / 800)),
                      ),
                      Row(
                        children: [
                          Text(
                            '4,8',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: screenSize.height * (13 / 800)),
                          ),
                          const Icon(Icons.star_rate_rounded),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const VerAvaliacao(isMotorista: true);
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
                        },
                        child: const Text(
                          'Ver detalhes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Motorista  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (15 / 800)),
                      ),
                      Row(
                        children: [
                          Text(
                            '4,8',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: screenSize.height * (13 / 800)),
                          ),
                          const Icon(Icons.star_rate_rounded),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const VerAvaliacao(isMotorista: true,);
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
                        },
                        child: const Text(
                          'Ver detalhes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            height: screenSize.height * (20 / 800),
          ),
          //editar perfil e veiculo, logout
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: screenSize.width * (35 / 360)),
            child: Column(
              children: [
                Container(
                  height: screenSize.height * (30 / 800),
                ),
                InkWell(
                  onTap: () {
                    print('Meus Veículos');
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return MeusVeiculos();
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car_filled_outlined,
                            size: screenSize.width * (27 / 360),
                          ),
                          Container(
                            width: screenSize.width * (10 / 360),
                          ),
                          Text(
                            'Meus Veículos',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: screenSize.height * (18 / 800)),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: screenSize.width * (20 / 360),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenSize.height * (30 / 800)),
                  child: const Divider(
                    height: 2, // Espessura da linha
                    color: Colors.grey, // Cor da linha
                  ),
                ),
                InkWell(
                  onTap: () {
                    googleSignIn.disconnect();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Login();
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: screenSize.width * (27 / 360),
                          ),
                          Container(
                            width: screenSize.width * (10 / 360),
                          ),
                          Text(
                            'Fazer Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: screenSize.height * (18 / 800)),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: screenSize.width * (20 / 360),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
