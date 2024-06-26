import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

import '../model/DAO/CaronaDAO.dart';
import '../model/modelos/Carona.dart';
import '../model/Services/routeService.dart';

class CaronaController {
  CaronaDAO caronaDAO;
  RouteService routeService;

  CaronaController()
      : caronaDAO = CaronaDAO(),
        routeService = RouteService();

  CaronaController.comFirestore({FirebaseFirestore? firestore})
      : caronaDAO = CaronaDAO.comFirestore(firestore: firestore),
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
    caronaDAO.salvarCarona(origem, dest, origemLocal, origemDestino, data, hora, autoAceitar, veiculoId, vagas, motoristaId, passageirosIds);
  }

  Future<List<Map<String, dynamic>>> buscarCaronasCompativeis(double latOrigem, double lonOrigem, double latDestino, double lonDestino, String data) async {
    List<Carona>? caronas = await caronaDAO?.buscarCaronasPorDataEVagas(data);
    List<Map<String, dynamic>> caronasCompativeis = [];

    for (var carona in caronas!) {
      Map<String, dynamic> routeData = await routeService.getRoute(carona.origem[0], carona.origem[1], carona.dest[0], carona.dest[1]);
      List? routeCarona = routeData['route'];
      int routeDuration = routeData['duration'];

      var nearestPickupPoint = routeService.getNearestPoint(routeCarona!, latOrigem, lonOrigem);
      var nearestDropoffPoint = routeService.getNearestPoint(routeCarona, latDestino, lonDestino);

      if (routeService.isPointNear(nearestPickupPoint, latOrigem, lonOrigem, 4000) && routeService.isPointNear(nearestDropoffPoint, latDestino, lonDestino, 4000)) {

        Map<String, dynamic> walkingStart = await routeService.distanciaCaminhada2(lonOrigem, latOrigem, nearestPickupPoint[0], nearestPickupPoint[1]);
        List? walkRouteStart = walkingStart['route'];
        Map<String, dynamic> walkingEnd = await routeService.distanciaCaminhada2(lonDestino, latDestino, nearestDropoffPoint[0], nearestDropoffPoint[1]);
        List? walkRouteEnd = walkingEnd['route'];
        
        caronasCompativeis.add({
          'carona': carona,
          'walkingDistanceStart': walkingStart['distance'],
          'walkingDistanceEnd': walkingEnd['distance'],
          'pickupPoint': nearestPickupPoint.reversed.toList(),
          'dropoffPoint': nearestDropoffPoint.reversed.toList(),
          'routeDuration': routeDuration,
          'route': routeCarona,
          'walkRouteStart': walkRouteStart,
          'walkRouteEnd': walkRouteEnd,
        });
      }
    }

    return caronasCompativeis;
  }

  Future<Carona?> recuperarCaronaPorId(String caronaId) async {
    return await caronaDAO?.recuperarCaronaPorId(caronaId);
  }

  Future<Carona?> recuperarCaronaPorIdDoc(String caronaId) async {
    return await caronaDAO?.recuperarCaronaPorIdDoc(caronaId);
  }

  Future<void> adicionarPassageiroNaCarona(String idCarona, String idPassageiro) async {
    await caronaDAO?.adicionarPassageiroNaCarona(idCarona, idPassageiro);
    await caronaDAO?.decrementarVagas(idCarona);
  }

  Future<String?> docIdString(String id) async {
    return await caronaDAO?.docIdString(id);
  }


}
