import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  final List<List<LatLng>>? route;
  final List<LatLng>? coordinates;
 
  const Mapa({super.key, this.route, this.coordinates});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late LatLng center;

  @override
  void initState() {
    _center();
    super.initState();
  }

  void _center(){
    if(widget.route == null){
      center = const LatLng(-22.90654345, -43.13314597657);
    }else{
      int i;
      i = widget.route![0].length ~/ 2;
      center = widget.route![0][i];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    if (widget.coordinates != null && widget.coordinates!.isNotEmpty) {
      // Lista de cores para os marcadores
      List<Color> markerColors = [
        Theme.of(context).colorScheme.onPrimaryContainer,
        Theme.of(context).colorScheme.onPrimaryContainer,
        Colors.purple,
        Colors.purple,
        Colors.red,
        Colors.red,
      ];

      // Gerar marcadores a partir das coordenadas fornecidas (se existirem)
      for (int i = 0; i < widget.coordinates!.length; i++) {
        markers.add(
          Marker(
            width: 50,
            height: 50,
            point: widget.coordinates![i],
            child: Icon(Icons.location_pin, color: markerColors[i]),
            //alignment: Alignment.center
          ),
        );
      }
    }

    List<Polyline> polylines = [];
    if(widget.route != null){
      for (int i = 0; i < widget.route!.length; i++) {
        Color color;
        double strokeWidth;

        if (i == 0) {
          color = Theme.of(context).colorScheme.primary;
          strokeWidth = 4;
        } else if (i == 1) {
          color = Colors.green;
          strokeWidth = 5;
        } else if (i == 2) {
          color = Colors.green;
          strokeWidth = 5;
        } else {
          break;
        }

        polylines.add(
          Polyline(
            points: widget.route![i],
            color: color,
            strokeWidth: strokeWidth,
          ),
        );
      }
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: 11,
        minZoom: 10,
        maxZoom: 15
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        
        if (polylines.isNotEmpty)
          PolylineLayer(
            polylines: polylines,
          ),

        if (markers.isNotEmpty)
          MarkerLayer(
            markers: markers, // Usar os marcadores gerados a partir das coordenadas (se existirem)
        ),
      ],
    );
  }
}
