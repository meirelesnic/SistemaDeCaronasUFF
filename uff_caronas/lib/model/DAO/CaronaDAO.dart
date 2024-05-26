import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/Carona.dart';

class CaronaDAO {
  final CollectionReference _caronasCollection = FirebaseFirestore.instance.collection('caronas');

  String _gerarId() {
    var random = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() + random.nextInt(9999).toString().padLeft(4, '0');
  }

  Future<void> salvarCarona(
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
      ) async {
    try {
      String id = _gerarId();

      await _caronasCollection.add({
        'id': id,
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
      });
    } catch (e) {
      print('Erro ao salvar carona: $e');
    }
  }

  Future<List<Carona>?> recuperarCaronasComoPassageiro(String idPassageiro) async {
    try {
      QuerySnapshot querySnapshot = await _caronasCollection.where('passageirosIds', arrayContains: idPassageiro).get();

      List<Carona> caronas = [];
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          Carona carona = Carona(
            id: data['id'],
            origem: List<double>.from(data['origem']),
            dest: List<double>.from(data['dest']),
            origemLocal: data['origemLocal'],
            origemDestino: data['origemDestino'],
            data: data['data'],
            hora: data['hora'],
            autoAceitar: data['autoAceitar'],
            veiculoId: data['veiculoId'],
            vagas: data['vagas'],
            motoristaId: data['motoristaId'],
            passageirosIds: data['passageirosIds'] != null ? List<String>.from(data['passageirosIds']) : null,
          );
          caronas.add(carona);
        }
      }

      return caronas;
    } catch (e) {
      print('Erro ao recuperar caronas como passageiro: $e');
      return null;
    }
  }

  Future<List<Carona>?> recuperarCaronasComoMotorista(String idMotorista) async {
    try {
      QuerySnapshot querySnapshot = await _caronasCollection.where('motoristaId', isEqualTo: idMotorista).get();

      List<Carona> caronas = [];
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          Carona carona = Carona(
            id: data['id'],
            origem: List<double>.from(data['origem']),
            dest: List<double>.from(data['dest']),
            origemLocal: data['origemLocal'],
            origemDestino: data['origemDestino'],
            data: data['data'],
            hora: data['hora'],
            autoAceitar: data['autoAceitar'],
            veiculoId: data['veiculoId'],
            vagas: data['vagas'],
            motoristaId: data['motoristaId'],
            passageirosIds: data['passageirosIds'] != null ? List<String>.from(data['passageirosIds']) : null,
          );
          caronas.add(carona);
        }
      }

      return caronas;
    } catch (e) {
      print('Erro ao recuperar caronas como motorista: $e');
      return null;
    }
  }
}

