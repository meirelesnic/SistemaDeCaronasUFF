import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:uff_caronas/model/Services/mapa.dart';
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
  List<LatLng> coord = [];
  List<LatLng> walk1 = [];
  List<LatLng> walk2 = [];

  List<LatLng> convertToLatLngList(List coordinates) {
    List<LatLng> latLngList = [];

    for (var c in coordinates) {
      latLngList.add(LatLng(c[0], c[1]));
    }
    return latLngList;
  }

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
              print(widget.caronasInfo[index].dropoffPoint[0]);
              Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        coord = convertToLatLngList(widget.caronasInfo[index].route);
                        walk1 = convertToLatLngList(widget.caronasInfo[index].walkRouteStart);
                        walk2 = convertToLatLngList(widget.caronasInfo[index].walkRouteEnd);
                        return Mapa(route: [
                                      coord,
                                      walk1,
                                      walk2
                                    ],
                                    coordinates: [
                                      LatLng(widget.caronas[index].origem[0], widget.caronas[index].origem[1]),
                                      LatLng(widget.caronas[index].dest[0], widget.caronas[index].dest[1]),
                                      LatLng(widget.caronasInfo[index].pickupPoint[0], widget.caronasInfo[index].pickupPoint[1]),
                                      LatLng(widget.caronasInfo[index].dropoffPoint[0], widget.caronasInfo[index].dropoffPoint[1]),
                                      LatLng(widget.or[0], widget.or[1]),
                                      LatLng(widget.de[0], widget.de[1])
                                    ],
                                );
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
