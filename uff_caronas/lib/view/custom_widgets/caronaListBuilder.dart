import 'package:flutter/material.dart';
import '../../model/DAO/AvaliacaoDAO.dart';
import '../../model/modelos/Carona.dart';
import 'caronaCard.dart';

class CaronaListBuilder extends StatefulWidget {
  final List<Carona> caronas;

  const CaronaListBuilder({required this.caronas, Key? key}) : super(key: key);

  @override
  State<CaronaListBuilder> createState() => _CaronaListBuilderState();
}

  

class _CaronaListBuilderState extends State<CaronaListBuilder> {
  
  Future<void> criaAvaliacao(List<Carona> caronas) async{
    for (var c in caronas) {
      List<String> ids = [];
      if(c.passageirosIds!.isNotEmpty){
        ids = c.passageirosIds!;
      }
      ids.add(c.motoristaId);
      await AvaliacaoDAO.criarOuVerificarAvaliacao(ids, c.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    criaAvaliacao(widget.caronas);
    final screenSize = MediaQuery.of(context).size; 
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (12 / 360)),
      child: ListView.builder(
        itemCount: widget.caronas.length,
        itemBuilder: (context, index){
          return CaronaCard(carona: widget.caronas[index]);
        }
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CaronaListBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.caronas != widget.caronas) {
      setState(() {});
    }
  }
}
