import 'package:flutter/material.dart';
import 'package:uff_caronas/view/custom_widgets/placa.dart';
import 'package:uff_caronas/view/editarVeiculo.dart';
import '../../model/modelos/Veiculo.dart';

class VeiculoCard extends StatefulWidget {
  final Veiculo veiculo;

  const VeiculoCard({Key? key, required this.veiculo}) : super(key: key);

  @override
  State<VeiculoCard> createState() => _VeiculoCardState();
}

class _VeiculoCardState extends State<VeiculoCard> {
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
                  Image.asset(
                    "image/car_icons/carro_${widget.veiculo.cor.toLowerCase()}.png",
                    width: screenSize.width * (1 / 7),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Marca: ${widget.veiculo.marca}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.height * (17 / 960))),
                      Text("Modelo: ${widget.veiculo.modelo}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.height * (17 / 960))),
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
                  Placa(
                      placa: widget.veiculo.placa,
                      width: screenSize.width * (115 / 360)),
                  Text("Cor: ${widget.veiculo.cor}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.height * (17 / 960))),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return EditarVeiculo(veiculo: widget.veiculo);
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
