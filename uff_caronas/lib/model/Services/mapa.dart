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
  late MapController mapController;

  @override
  void initState() {
    //_center();
    super.initState();
    mapController = MapController();
    //mapController.fitCamera(CameraFit.coordinates(coordinates: widget.coordinates!, padding: const EdgeInsets.all(35)));
   // print('initState');
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.route != null && widget.route!.isNotEmpty) {
        
        mapController.fitCamera(CameraFit.coordinates(coordinates: widget.route![0], padding: const EdgeInsets.all(35)));
        //mapController.fitCamera(CameraFit.coordinates(coordinates: widget.coordinates!, padding: const EdgeInsets.all(35)));

      }
    });

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(-22.90654345, -43.13314597657),
        initialZoom: 10,
        minZoom: 7.1,
        maxZoom: 15.5,
        interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate)
      ),
      children: [
        TileLayer(
          //'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
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
