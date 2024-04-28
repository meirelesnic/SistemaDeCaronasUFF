import 'package:flutter/material.dart';
import 'package:uff_caronas/custom_widgets/caronaCard.dart';

class CaronaListBuilder extends StatefulWidget {
  const CaronaListBuilder({super.key});

  @override
  State<CaronaListBuilder> createState() => _CaronaListBuilderState();
}

class _CaronaListBuilderState extends State<CaronaListBuilder> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; 
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * (12 / 360)),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){
          return CaronaCard();
        }
      ),
    );
  }
}