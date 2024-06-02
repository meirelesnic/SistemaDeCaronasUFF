import 'package:flutter/material.dart';

class PedidoCard extends StatefulWidget {
  const PedidoCard({super.key});

  @override
  State<PedidoCard> createState() => _PedidoCardState();
}

class _PedidoCardState extends State<PedidoCard> {
  String _status = "Pendente";
  int widthScale = 500;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: screenSize.width * (313 / 360),
        height: screenSize.height * (188 / 800),
        child: Container(
          padding: EdgeInsets.all(screenSize.width * (10 / 360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //origem
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * (5 / widthScale)),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: screenSize.width * (20 / widthScale),
                        ),
                      ),
                      Text(
                        'Local Origem',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (14 / 800)),
                      )
                    ],
                  ),
                  Text(
                    _status,
                    style: _status == "Pendente"
                        ? TextStyle(
                            color: const Color.fromARGB(255, 187, 72, 72))
                        : TextStyle(color: Colors.grey.shade700),
                  )
                ],
              ),
              //destino
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * (5 / widthScale)),
                    child: Icon(
                      Icons.sports_score_rounded,
                      size: screenSize.width * (20 / widthScale),
                    ),
                  ),
                  Text(
                    'Local Destino',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * (14 / 800)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //data
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * (5 / widthScale)),
                        child: Icon(
                          Icons.schedule_rounded,
                          size: screenSize.width * (20 / widthScale),
                        ),
                      ),
                      Text(
                        '00/00/2000 - 00:00h',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.height * (14 / 800)),
                      )
                    ],
                  ),
                  FilledButton(
                    onPressed: () {
                      //Tela detalhes, passando ID da carona
                    },
                    child: Text('Apagar'),
                    // style: ButtonStyle(
                    //   backgroundColor: WidgetStateProperty.all(
                    //       Color.fromARGB(255, 187, 72, 72)),
                    // ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
