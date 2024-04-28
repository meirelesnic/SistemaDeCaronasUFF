import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uff_caronas/telas/editarPerfil.dart';
import 'package:uff_caronas/telas/editarVeiculo.dart';
import 'package:uff_caronas/telas/motoristaAvaliacao.dart';
import 'package:uff_caronas/telas/passageiroAvaliacao.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
                        backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/man-with-glasses-backpack-street-corner-smiling-camera-with-blurry-background_961147-49483.jpg?w=1060'),
                      ),
                    ),
                    Text('Antônio Pedro',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: screenSize.height * (25/800)
                      ),
                    ),
                    Text('antoniopedro@id.uff.br',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: screenSize.height * (15/800)
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
          //Avaliacao
          Container(
            margin: EdgeInsets.symmetric(vertical: screenSize.height * (15/800)),
            padding: EdgeInsets.all(screenSize.height * (15/800)),
            width: screenSize.width * (313/360),
            height: screenSize.height * (169/800),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suas Avaliações',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: screenSize.height * (22/800)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Passageiro',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * (15/800)
                      ),
                    ),
                    Row(
                      children: [
                        Text('4,8',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: screenSize.height * (13/800)
                          ),
                        ),
                        const Icon(Icons.star_rate_rounded),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return PassageiroAvaliacao();
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
                    Text('Motorista  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * (15/800)
                      ),
                    ),
                    Row(
                      children: [
                        Text('4,8',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: screenSize.height * (13/800)
                          ),
                        ),
                        const Icon(Icons.star_rate_rounded),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return MotoristaAvaliacao();
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
            )
          ),
          Container(
            height: screenSize.height * (20/800),
          ),
          //editar perfil e veiculo, logout
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * (35/360)),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    print('editar usuario');
                    Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return EditarPerfil();
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: screenSize.width * (27/360),
                          ),
                          Container(
                            width: screenSize.width * (10/360),
                          ),
                          Text('Editar dados de perfil',
                              style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: screenSize.height * (18/800)
                            ),
                          ),
                        ],
                      
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: screenSize.width * (20/360),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenSize.height * (30/800),
                ),
                InkWell(
                  onTap: () {
                    print('editar veiculo');
                    Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return EditarVeiculo();
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car_filled_outlined,
                            size: screenSize.width * (27/360),
                          ),
                          Container(
                            width: screenSize.width * (10/360),
                          ),
                          Text('Editar dados do veículo',
                              style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: screenSize.height * (18/800)
                            ),
                          ),
                        ],
                      
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: screenSize.width * (20/360),
                      ),
                    ],
                  ),
                ),
      
                Padding(
                  padding: EdgeInsets.all(screenSize.height * (30/800)),
                  child: const Divider(
                    height: 2,  // Espessura da linha
                    color: Colors.grey,  // Cor da linha
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('fazer logout');
                    //desautenticar e voltar pra tela de login
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: screenSize.width * (27/360),
                          ),
                          Container(
                            width: screenSize.width * (10/360),
                          ),
                          Text('Fazer Logout',
                              style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: screenSize.height * (18/800)
                            ),
                          ),
                        ],
                      
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: screenSize.width * (20/360),
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