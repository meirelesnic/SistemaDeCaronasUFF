import 'package:flutter/material.dart';
import '../../model/modelos/Carona.dart';
import '../../model/modelos/CaronaInfo.dart';
import 'buscaCaronaCard.dart';
import 'caronaCard.dart';

class BuscaCaronaListBuilder extends StatefulWidget {
  final List<Carona> caronas;
  final List<CaronaInfo> caronasInfo;
  final List<double> or;
  final List<double> de;

  const BuscaCaronaListBuilder({required this.caronas, Key? key, required this.caronasInfo, required this.or, required this.de}) : super(key: key);

  @override
  State<BuscaCaronaListBuilder> createState() => _BuscaCaronaListBuilderState();
}

class _BuscaCaronaListBuilderState extends State<BuscaCaronaListBuilder> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; 
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (12 / 360)),
      child: ListView.builder(
        itemCount: widget.caronas.length,
        itemBuilder: (context, index){
          return GestureDetector(child: BuscaCaronaCard(carona: widget.caronas[index], info: widget.caronasInfo[index],),
            onTap: () {
              print('Rota: ${widget.caronasInfo[index].route}');
            },
          );
        }
      ),
    );
  }

  @override
  void didUpdateWidget(covariant BuscaCaronaListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.caronas != widget.caronas) {
      setState(() {});
    }
  }
}
