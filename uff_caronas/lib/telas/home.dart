import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uff_caronas/telas/oferecerCarona.dart';
import 'package:uff_caronas/telas/pedirCarona.dart';

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
                      color: Theme.of(context).colorScheme.secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondaryContainer, // cor da linha de contorno
                      width: 2.0, // largura da linha de contorno
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenSize.width * (25/360)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: screenSize.width * (39 / 360),
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage('https://gravatar.com/avatar/fa477d3f9bb01b5dc6e3c81e79434b36?s=400&d=robohash&r=x'),
                      ),
                      Container(
                        width: screenSize.width * (15/360),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bem-Vindo!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: screenSize.height * (33/800)
                            ),
                          ),
                          Text('Nome',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: screenSize.height * (17/800)
                            ),
                          )
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
                  fontSize: screenSize.height * (18/800)
                )
              ),
            ),
            InkWell(
              onTap: () {
                print('Pedir');
                Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PedirCarona();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                margin: EdgeInsets.symmetric(vertical: screenSize.height * (10/800)),
                width: screenSize.width * (313/360),
                height: screenSize.height * (169/800),
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
                        Text('Pedir Carona',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (18/800)
                          ),
                        ),
                        Text('Sou Passageiro')
                      ],
                    ),
                    Image.asset('image/pedir.png')
                  ],
                )
              )
            ),
            InkWell(
              onTap: () {
                print('Oferecer');
                Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return OferecerCarona();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                margin: EdgeInsets.symmetric(vertical: screenSize.height * (10/800)),
                width: screenSize.width * (313/360),
                height: screenSize.height * (169/800),
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
                        Text('Oferecer Carona',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (18/800)
                          ),
                        ),
                        Text('Sou Motorista')
                      ],
                    ),
                    Image.asset('image/oferecer.png')
                  ],
                )
              )
            )
          ],
        ),            
      ),
    );
  }
}
