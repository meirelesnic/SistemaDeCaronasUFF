import 'package:flutter/material.dart';

import '../../model/modelos/Veiculo.dart';
import 'placa.dart';

class VeiculoData extends StatefulWidget {
  final Veiculo veiculo;
  const VeiculoData({super.key, required this.veiculo});

  @override
  State<VeiculoData> createState() => _VeiculoDataState();
}

class _VeiculoDataState extends State<VeiculoData> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return  Container(
      padding: const EdgeInsets.all(18),
      //color: Theme.of(context).colorScheme.inversePrimary,
      decoration: BoxDecoration(
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
          top: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer, // cor da linha de contorno
            width: 2.0, // largura da linha de contorno
          ),
        ),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Image.asset(
                "image/car_icons/carro_${widget.veiculo.cor.toLowerCase()}.png",
                width: screenSize.width * (32 / 360),
              ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(widget.veiculo.marca,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: screenSize.height * (14 / 800),
                ),
              ),
              Text(widget.veiculo.modelo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.height * (16 / 800),
                ),
              ),
            ],
          ),
          const Spacer(),
          Placa(placa: widget.veiculo.placa, width: screenSize.width * (115/360)),
        ],
      ),
    );
  }
}