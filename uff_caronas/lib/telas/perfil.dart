import 'package:flutter/material.dart';

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
      body: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: screenSize.height * (245 / 800.0),
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
                  width: screenSize.width,
                  //alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * (12 / 360)),
                        child: CircleAvatar(
                          radius: screenSize.width * (61 / 360),
                          backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage('https://gravatar.com/avatar/fa477d3f9bb01b5dc6e3c81e79434b36?s=400&d=robohash&r=x'),
                        ),
                      ),
                      Text('Nome',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: screenSize.height * (25/800)
                        ),
                      ),
                      Text('email@id.uff.br',
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          Icon(Icons.star_rate_rounded),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
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
                          Icon(Icons.star_rate_rounded),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
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
                  Row(
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
                  Container(
                    height: screenSize.height * (30/800),
                  ),
                  Row(
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

                  Padding(
                    padding: EdgeInsets.all(screenSize.height * (30/800)),
                    child: Divider(
                      height: 1,  // Espessura da linha
                      color: Colors.grey,  // Cor da linha
                    ),
                  ),
                  Row(
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
                  )
                ],
              ),
            )         
          ],
        ),            
      ),
    );

  }
}