import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uff_caronas/view/caronaEmEspera.dart';
import 'package:uff_caronas/view/oferecerCarona.dart';
import 'package:uff_caronas/view/pedirCarona.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: screenSize.height * (130.0 / 800.0),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
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
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * (25 / 360)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: screenSize.width * (39 / 360),
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(user!.fotoUrl),
                      ),
                      Container(
                        width: screenSize.width * (15 / 360),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bem-Vindo!',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                          Text(user!.nome,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            //botoes Pedir oferecer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text('O que deseja?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.height * (18 / 800))),
            ),
            InkWell(
                onTap: () {
                  print('Pedir');
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return PedirCarona();
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
                child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * (10 / 800)),
                    width: screenSize.width * (313 / 360),
                    height: screenSize.height * (150 / 800),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pedir Carona',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.height * (18 / 800)),
                            ),
                            Text('Sou Passageiro')
                          ],
                        ),
                        Image.asset('image/pedir.png')
                      ],
                    ))),
            InkWell(
                onTap: () {
                  print('Oferecer');
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return OferecerCarona();
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
                child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * (10 / 800)),
                    width: screenSize.width * (313 / 360),
                    height: screenSize.height * (150 / 800),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Oferecer Carona',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.height * (18 / 800)),
                            ),
                            Text('Sou Motorista')
                          ],
                        ),
                        Image.asset('image/oferecer.png')
                      ],
                    ))),
            Container(
              height: screenSize.height * (30 / 800),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * (35 / 360)),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return CaronaEmEspera();
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
                              Icons.person_outline,
                              size: screenSize.width * (27 / 360),
                            ),
                            Container(
                              width: screenSize.width * (10 / 360),
                            ),
                            Text(
                              'Aprovar Passageiro',
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
                  Container(
                    height: screenSize.height * (30 / 800),
                  ),
                  InkWell(
                    onTap: () {
                      print('editar veiculo');
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return CaronaEmEspera();
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
                              'Pedido Armazenado',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
