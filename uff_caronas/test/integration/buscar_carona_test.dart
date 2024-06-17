import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:uff_caronas/controller/CaronaController.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/model/modelos/CaronaInfo.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late CaronaController caronaController;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    caronaController = CaronaController.comFirestore(firestore: firestore);
  });

  test('comportamento da tela de buscarCarona', () async {
    String data = "2023-06-13";
    String hora = "08:00";

    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    DateTime dateTime = dateFormat.parse('$data $hora');
    Timestamp timestamp = Timestamp.fromDate(dateTime);

    Map<String, dynamic> caronaData = {
      'origem': [-22.9068, -43.1729],
      'dest': [-22.9083, -43.1964],
      'origemLocal': "Local de Origem",
      'origemDestino': "Local de Destino",
      'data': data,
      'hora': hora,
      'autoAceitar': true,
      'veiculoId': "veiculo123",
      'vagas': 3,
      'motoristaId': "motorista123",
      'passageirosIds': ["passageiro1", "passageiro2"],
      'dataTimestamp': timestamp,
    };

    await firestore.collection('caronas').add(caronaData);

    var snapshot = await firestore.collection('caronas').get();
    expect(snapshot.docs.length, 1);

    var caronas = await caronaController.buscarCaronasCompativeis(
      -22.9068,
      -43.1729,
      -22.9083,
      -43.1964,
      "2023-06-13",
    );
    expect(caronas.isNotEmpty, true);

    var caronasList = caronas.map((mapa) => mapa['carona'] as Carona).toList();
    expect(caronasList.isNotEmpty, true);

    var caronaInfosList = caronas.map((mapa) => CaronaInfo(
      carona: mapa['carona'] as Carona,
      walkingDistanceStart: mapa['walkingDistanceStart'],
      walkingDistanceEnd: mapa['walkingDistanceEnd'],
      pickupPoint: mapa['pickupPoint'] as List<double>,
      dropoffPoint: mapa['dropoffPoint'] as List<double>,
      routeDuration: mapa['routeDuration'] as int,
      route: mapa['route'] as List,
      walkRouteEnd: mapa['walkRouteEnd'] as List,
      walkRouteStart: mapa['walkRouteStart'] as List,
    )).toList();

    expect(caronaInfosList.isNotEmpty, true);
  });

}
