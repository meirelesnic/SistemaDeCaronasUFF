import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:uff_caronas/model/DAO/CaronaDAO.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late CaronaDAO caronaDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    caronaDAO = CaronaDAO.comFirestore(firestore: firestore);

  });

  test('Deve salvar uma carona corretamente', () async {
    List<double> origem = [0.0, 0.0];
    List<double> dest = [1.0, 1.0];
    String origemLocal = "Local de Origem";
    String origemDestino = "Local de Destino";
    String data = "2023-06-13";
    String hora = "08:00";
    bool autoAceitar = true;
    String veiculoId = "veiculo123";
    int vagas = 3;
    String motoristaId = "motorista123";
    List<String?> passageirosIds = ["passageiro1", "passageiro2"];

    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    DateTime dateTime = dateFormat.parse('$data $hora');
    Timestamp timestamp = Timestamp.fromDate(dateTime);

    Map<String, dynamic> caronaData = {
      'origem': origem,
      'dest': dest,
      'origemLocal': origemLocal,
      'origemDestino': origemDestino,
      'data': data,
      'hora': hora,
      'autoAceitar': autoAceitar,
      'veiculoId': veiculoId,
      'vagas': vagas,
      'motoristaId': motoristaId,
      'passageirosIds': passageirosIds,
      'dataTimestamp': timestamp,
    };

    await firestore.collection('caronas').add(caronaData);

    var snapshot = await firestore.collection('caronas').get();
    expect(snapshot.docs.length, 1);
    var carona = snapshot.docs.first.data();
    expect(carona['origem'], origem);
    expect(carona['dest'], dest);
    expect(carona['origemLocal'], origemLocal);
    expect(carona['origemDestino'], origemDestino);
    expect(carona['data'], data);
    expect(carona['hora'], hora);
    expect(carona['autoAceitar'], autoAceitar);
    expect(carona['veiculoId'], veiculoId);
    expect(carona['vagas'], vagas);
    expect(carona['motoristaId'], motoristaId);
    expect(carona['passageirosIds'], passageirosIds);
  });

  test('Recuperar caronas como passageiro', () async {
    await firestore.collection('caronas').add({
      'id': '1',
      'origem': [0.0, 0.0],
      'dest': [1.0, 1.0],
      'origemLocal': 'Local de origem',
      'origemDestino': 'Local de destino',
      'data': '2024-06-13',
      'hora': '12:00',
      'autoAceitar': true,
      'veiculoId': 'xyz123',
      'vagas': 2,
      'motoristaId': 'motorista123',
      'passageirosIds': ['passageiro456', 'passageiro789'],
    });

    List<Carona>? caronas = await caronaDAO.recuperarCaronasComoPassageiro('passageiro456');

    expect(caronas?.length, 1);
    expect(caronas?[0].id, '1');
  });

  test('Recuperar caronas como motorista', () async {
    await firestore.collection('caronas').add({
      'id': '1',
      'origem': [0.0, 0.0],
      'dest': [1.0, 1.0],
      'origemLocal': 'Local de origem',
      'origemDestino': 'Local de destino',
      'data': '2024-06-13',
      'hora': '12:00',
      'autoAceitar': true,
      'veiculoId': 'xyz123',
      'vagas': 2,
      'motoristaId': 'motorista123',
      'passageirosIds': ['passageiro456', 'passageiro789'],
    });

    List<Carona>? caronas = await caronaDAO.recuperarCaronasComoMotorista('motorista123');

    expect(caronas?.length, 1);
    expect(caronas?[0].id, '1');
  });

  test('Buscar caronas por data e vagas', () async {
    await firestore.collection('caronas').doc('carona1').set({
      'id': '1',
      'origem': [0.0, 0.0],
      'dest': [1.0, 1.0],
      'origemLocal': 'Local de origem',
      'origemDestino': 'Local de destino',
      'data': '2024-06-13',
      'hora': '12:00',
      'autoAceitar': true,
      'veiculoId': 'xyz123',
      'vagas': 2,
      'motoristaId': 'motorista123',
      'passageirosIds': ['passageiro456', 'passageiro789'],
    });

    List<Carona>? caronas = await caronaDAO.buscarCaronasPorDataEVagas('2024-06-13');

    expect(caronas, isNotNull);
    expect(caronas!.length, greaterThan(0));

    expect(caronas![0].id, 'carona1');
  });
}