import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/Veiculo.dart';

class VeiculoDAO {
  final CollectionReference _veiculosCollection =
  FirebaseFirestore.instance.collection('veiculos');

  String _gerarId() {
    var random = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  Future<void> salvarVeiculo(String modelo, String marca, int ano) async {
    try {
      String id = _gerarId();

      await _veiculosCollection.add({
        'id': id,
        'modelo': modelo,
        'marca': marca,
        'ano': ano,
      });

    } catch (e) {
      print('Erro ao salvar veículo: $e');
    }
  }

  Future<Veiculo?> recuperarVeiculo(String id) async {
    try {
      QuerySnapshot querySnapshot = await _veiculosCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return Veiculo(
            id: snapshot.id,
            modelo: data['modelo'],
            marca: data['marca'],
            ano: data['ano'],
          );
        } else {
          throw ('Dados do veículo são nulos');
        }
      } else {
        throw ('Veículo não encontrado');
      }
    } catch (e) {
      print('Erro ao recuperar veículo: $e');
      return null;
    }
  }


}