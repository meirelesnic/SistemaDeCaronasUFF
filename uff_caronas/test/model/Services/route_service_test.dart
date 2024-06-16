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
    final startLat = -22.9068;
    final startLng = -43.1729;
    final endLat = -22.9083;
    final endLng = -43.1964;

    final distance = await routeService.distanciaCaminhada(startLat, startLng, endLat, endLng);

    expect(double.parse(distance), greaterThan(0));
  });

  test('Deve obter a rota de caminhada e distância', () async {
    final startLat = -22.9068;
    final startLng = -43.1729;
    final endLat = -22.9083;
    final endLng = -43.1964;

    // Chamada ao método distanciaCaminhada2
    final result = await routeService.distanciaCaminhada2(startLat, startLng, endLat, endLng);

    // Imprime o resultado para depuração
    print('Resultado: $result');

    // Verifica se a rota não está vazia
    expect(result['route'], isNotEmpty, reason: 'A rota não deveria estar vazia');

    // Verifica se a distância é maior que zero
    expect(double.parse(result['distance']), greaterThan(0), reason: 'A distância deveria ser maior que zero');
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

  test('Deve verificar se um ponto está perto de outro ponto', () async {
    final point = [-22.9068, -43.1729];
    final lat = -22.907;
    final lng = -43.173;
    final maxDistance = 500.0;

    final isNear = routeService.isPointNear(point, lat, lng, maxDistance);

    expect(isNear, isTrue);
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
