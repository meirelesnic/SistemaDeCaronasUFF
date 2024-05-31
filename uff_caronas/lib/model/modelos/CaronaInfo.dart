import 'Carona.dart';

class CaronaInfo {
  final Carona carona;
  final String walkingDistanceEnd;
  final String walkingDistanceStart;
  final List<double> pickupPoint;
  final List<double> dropoffPoint;
  final int routeDuration;
  final List route;
  final List walkRouteEnd;
  final List walkRouteStart;

  CaronaInfo({
    required this.carona,
    required this.walkingDistanceStart,
    required this.walkingDistanceEnd,
    required this.pickupPoint,
    required this.dropoffPoint,
    required this.routeDuration,
    required this.route,
    required this.walkRouteEnd,
    required this.walkRouteStart,
  });
}
