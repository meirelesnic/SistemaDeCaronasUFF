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

  Future<Carona?> recuperarCarona(String id) async {
    try {
      QuerySnapshot querySnapshot = await _caronasCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          return Carona(
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
        } else {
          throw ('Dados da carona são nulos');
        }
      } else {
        throw ('Carona não encontrada');
      }
    } catch (e) {
      print('Erro ao recuperar carona: $e');
      return null;
    }
  }

  Future<void> editarCarona(String id, List<double> novaOrigem, List<double> novoDest) async {
    try {
      var querySnapshot = await _caronasCollection.where('id', isEqualTo: id).get();
      await _caronasCollection.doc(querySnapshot.docs.first.id).update({'origem': novaOrigem, 'dest': novoDest});
    } catch (e) {
      print('Erro ao atualizar a carona: $e');
    }
  }

  Future<List<Carona>?>? recuperarCaronasPorUsuario(String idUsuario) async {
    try {
      QuerySnapshot querySnapshot = await _caronasCollection.where('motoristaId', isEqualTo: idUsuario).get();

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
      print('Erro ao recuperar caronas do usuário: $e');
      return null;
    }
  }

}
