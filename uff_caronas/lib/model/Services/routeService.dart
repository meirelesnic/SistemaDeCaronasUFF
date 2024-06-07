import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class RouteService {
  final String apiKey = '5b3ce3597851110001cf624848d99bd3298d44d9af6fde13363151a9';

  RouteService();

  Future<Map<String, dynamic>> getRoute(double startLat, double startLng, double endLat, double endLng) async {
    final url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat';
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        final route = data['features'][0]['geometry']['coordinates'];
        final duration = data['features'][0]['properties']['segments'][0]['duration'];
        //print(data);
        return {
          'route': route.map((point) => [point[1], point[0]]).toList(),
          'duration': (duration / 60).ceil()
        };
      }
    }
    
    return {
      'route': [],
      'duration': 0
    };
  }

  Future<List<LatLng>> getRouteLatLng(double startLat, double startLng, double endLat, double endLng) async {
    final url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat';
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        final route = data['features'][0]['geometry']['coordinates'];
        return route.map<LatLng>((point) => LatLng(point[1], point[0])).toList();
      }
    }
    
    return <LatLng>[];
  }

  Future<Map<String, dynamic>> distanciaCaminhada2(double startLat, double startLng, double endLat, double endLng) async {
    final url = 'https://api.openrouteservice.org/v2/directions/foot-walking?api_key=$apiKey&start=$startLat,$startLng&end=$endLat,$endLng';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        final route = data['features'][0]['geometry']['coordinates'];
        double distanciaMetros = data['features'][0]['properties']['segments'][0]['distance'];
        double distanciaKm = distanciaMetros / 1000; 
        return {
          'route': route.map((point) => [point[1], point[0]]).toList(),
          'distance': distanciaKm.toStringAsFixed(2)
        };
      }
    }
    return {
      'route': [],
      'distance': '0.0'
    };
  }


  Future<String> distanciaCaminhada(double startLat, double startLng, double endLat, double endLng) async {
    final url = 'https://api.openrouteservice.org/v2/directions/foot-walking?api_key=$apiKey&start=$startLat,$startLng&end=$endLat,$endLng';
    //print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        double distanciaMetros = data['features'][0]['properties']['segments'][0]['distance'];
        double distanciaKm = distanciaMetros / 1000; 
        //print('${distanciaKm.toStringAsFixed(2)} km');
        return distanciaKm.toStringAsFixed(2);
      }
    }
    return '0.0';
  }

  bool isPointNearRoute(List route, double lat, double lng, double threshold) {
    for (var point in route) {
      print(point[0]);
      print(point[1]);
      double distance = Geolocator.distanceBetween(point[0], point[1], lat, lng);
      if (distance < threshold) {
        return true;
      }
    }
    return false;
  }

  List<double> getNearestPoint(List route, double lat, double lng) {
    double minDistance = double.infinity;
    List<double> nearestPoint = [];

    for (var point in route) {
      double distance = Geolocator.distanceBetween(point[0], point[1], lat, lng);
      if (distance < minDistance) {
        minDistance = distance;
        nearestPoint = [point[1], point[0]];
      }
    }
    print(minDistance);
    return nearestPoint;
  }

  bool isPointNear(List<double> point, double lat, double lng, double maxDistance) {
    double distance = Geolocator.distanceBetween(point[1], point[0], lat, lng);
    print(distance);
    return distance <= maxDistance;
  }

  Future<List<String>> getAddressFromLatLng(double lat, double lng) async {
    final url = 'https://api.openrouteservice.org/geocode/reverse?api_key=$apiKey&point.lat=$lat&point.lon=$lng&size=1';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final addressDetails = data['features'][0]['properties'];
      final street = addressDetails['street'] ?? 'No street info';
      final cityAndBorough = '${addressDetails['locality'] ?? ''}, ${addressDetails['county'] ?? ''}';
      return [street, cityAndBorough];
    } else {
      throw Exception('Failed to load address');
    }
  }

}
