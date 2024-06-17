import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/Services/routeService.dart';
import 'package:latlong2/latlong.dart';

void main() {
  late RouteService routeService;

  setUp(() {
    routeService = RouteService();
  });

  test('Deve obter uma rota de carro entre dois pontos', () async {
    final startLat = -22.9068;
    final startLng = -43.1729;
    final endLat = -22.9083;
    final endLng = -43.1964;

    final result = await routeService.getRoute(startLat, startLng, endLat, endLng);

    expect(result['route'], isNotEmpty);
    expect(result['duration'], greaterThan(0));
  });

  test('Deve obter uma rota de carro como lista de LatLng', () async {
    final startLat = -22.9068;
    final startLng = -43.1729;
    final endLat = -22.9083;
    final endLng = -43.1964;

    final route = await routeService.getRouteLatLng(startLat, startLng, endLat, endLng);

    expect(route, isNotEmpty);
    expect(route.first, isA<LatLng>());
  });

  test('Deve obter a distância de caminhada entre dois pontos', () async {
    final startLat = -22.9515096;
    final startLng = -43.1862969;
    final endLat = -22.97570575;
    final endLng = -43.18662424789011;

    final distance = await routeService.distanciaCaminhada(startLat, startLng, endLat, endLng);

    expect(double.parse(distance), 0);
  });

  test('Deve verificar se um ponto está perto de uma rota', () async {
    final route = [
      [-22.9068, -43.1729],
      [-22.9083, -43.1964]
    ];
    final lat = -22.907;
    final lng = -43.174;

    final isNear = routeService.isPointNearRoute(route, lat, lng, 500);

    expect(isNear, isTrue);
  });

  test('Deve obter o ponto mais próximo de uma rota', () async {
    final route = [
      [-22.9068, -43.1729],
      [-22.9083, -43.1964]
    ];
    final lat = -22.907;
    final lng = -43.174;

    final nearestPoint = routeService.getNearestPoint(route, lat, lng);

    expect(nearestPoint, isNotEmpty);
  });

  test('Deve verificar se um ponto está perto de outro ponto', () {
    expect(routeService.isPointNear([20.0, 10.0], 10.0, 20.0, 100), true);

    expect(routeService.isPointNear([30.0, 15.0], 10.0, 20.0, 100), false);
  });

  test('Deve obter o endereço de um ponto (lat, lng)', () async {
    final lat = -22.9068;
    final lng = -43.1729;

    final address = await routeService.getAddressFromLatLng(lat, lng);

    expect(address, isNotEmpty);
    expect(address[0], isNotEmpty);
    expect(address[1], isNotEmpty);
  });
}
