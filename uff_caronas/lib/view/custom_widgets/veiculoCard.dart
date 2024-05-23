import 'package:flutter/material.dart';
import 'package:uff_caronas/view/editarVeiculo.dart';

class VeiculoCard extends StatefulWidget {
  const VeiculoCard({super.key});

  @override
  State<VeiculoCard> createState() => _VeiculoCardState();
}

class _VeiculoCardState extends State<VeiculoCard> {
  String carColor = "preto"; 
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: screenSize.width * (313 / 360),
        height: screenSize.height * (1 / 6),
        child: Container(
          padding: EdgeInsets.all(screenSize.width * (15 / 360)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Image.asset(
                    "image/car_icons/carro_$carColor.png",
                    width: screenSize.width * (1 / 7),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Marca: Chevrolet",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: screenSize.height * (1 / 60),
                      ),
                      Text("Modelo: Prisma",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: screenSize.height * (2 / 60),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LTZ1435",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.height * 1 / 40),
                    ),
                    Text("Cor: Branco",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return EditarVeiculo();
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
                child: Icon(
                  Icons.edit_outlined,
                  size: screenSize.width * (2 / 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
