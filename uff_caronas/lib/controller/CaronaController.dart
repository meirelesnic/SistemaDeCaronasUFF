import '../model/DAO/CaronaDAO.dart';
import '../model/modelos/Carona.dart';
import '../model/Services/routeService.dart';

class CaronaController {
  CaronaDAO? caronaDAO;
  RouteService routeService;

  CaronaController()
    : caronaDAO = CaronaDAO(),
      routeService = RouteService();


  void salvarCarona(
      List<double> origem,
      List<double> dest,
      String origemLocal,
      String origemDestino,
      String data,
      String hora,
      bool autoAceitar,
      String veiculoId,
      int vagas,
      String motoristaId,
      List<String?> passageirosIds,
      ) {
    caronaDAO?.salvarCarona(origem, dest, origemLocal, origemDestino, data, hora, autoAceitar, veiculoId, vagas, motoristaId, passageirosIds);
  }

  Future<List<Map<String, dynamic>>> buscarCaronasCompativeis(double latOrigem, double lonOrigem, double latDestino, double lonDestino, String data) async {
    List<Carona>? caronas = await caronaDAO?.buscarCaronasPorDataEVagas(data);
    List<Map<String, dynamic>> caronasCompativeis = [];

    // Verificar compatibilidade das caronas com os pontos de origem e destino do usuário
    for (var carona in caronas!) {
      print(carona.origemLocal);
      Map<String, dynamic> routeData = await routeService.getRoute(carona.origem[0], carona.origem[1], carona.dest[0], carona.dest[1]);
      List? routeCarona = routeData['route'];
      int routeDuration = routeData['duration'];
      //print(routeData['route']);

      // Encontrar os pontos mais próximos na rota para os pontos de origem e destino do usuário
      var nearestPickupPoint = routeService.getNearestPoint(routeCarona!, latOrigem, lonOrigem);
      var nearestDropoffPoint = routeService.getNearestPoint(routeCarona, latDestino, lonDestino);

      // Verificar se esses pontos estão a uma distância razoável dos pontos de origem e destino do usuário
      if (routeService.isPointNear(nearestPickupPoint, latOrigem, lonOrigem, 4000) && routeService.isPointNear(nearestDropoffPoint, latDestino, lonDestino, 4000)) {
        String walkingDistanceStart = await routeService.distanciaCaminhada(lonOrigem, latOrigem, nearestPickupPoint[0], nearestPickupPoint[1]);
        String walkingDistanceEnd = await routeService.distanciaCaminhada(lonDestino, latDestino, nearestDropoffPoint[0], nearestDropoffPoint[1]);

        caronasCompativeis.add({
          'carona': carona,
          'walkingDistanceStart': walkingDistanceStart,
          'walkingDistanceEnd': walkingDistanceEnd,
          'pickupPoint': nearestPickupPoint,
          'dropoffPoint': nearestDropoffPoint,
          'routeDuration': routeDuration,
          'route': routeCarona,  // Adicionando a rota aqui
        });
      }
    }

    return caronasCompativeis;
  }


}
