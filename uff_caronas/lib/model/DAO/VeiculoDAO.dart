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

  Future<void> salvarVeiculo(String modelo, String marca, String cor, int ano, String userId, String placa) async {
    try {
      String id = _gerarId();

      await _veiculosCollection.add({
        'id': id,
        'modelo': modelo,
        'marca': marca,
        'cor': cor,
        'ano': ano,
        'usuarioId': userId,
        'placa': placa
      });
    } catch (e) {
      print('Erro ao salvar veículo: $e');
    }
  }

    Future<Veiculo?> recuperarVeiculoDoc(String id) async {
    try {
      DocumentSnapshot snapshot = await _veiculosCollection.doc(id).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return Veiculo(
            id: snapshot.id,
            modelo: data['modelo'],
            marca: data['marca'],
            ano: data['ano'],
            cor: data['cor'],
            usuarioId: data['usuarioId'],
            placa: data['placa'],
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

  Future<Veiculo?> recuperarVeiculo(String id) async {
    try {
      QuerySnapshot querySnapshot =
      await _veiculosCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return Veiculo(
              id: snapshot.id,
              modelo: data['modelo'],
              marca: data['marca'],
              ano: data['ano'],
              cor: data['cor'],
              usuarioId: data['usuarioId'],
              placa: data['placa']
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

  Future<List<Veiculo>> recuperarVeiculosPorUsuario(String userId) async {
    try {
      QuerySnapshot querySnapshot =
      await _veiculosCollection.where('usuarioId', isEqualTo: userId).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          return Veiculo(
            id: doc.id,
            modelo: data!['modelo'],
            marca: data['marca'],
            ano: data['ano'],
            cor: data['cor'],
            usuarioId: data['usuarioId'],
            placa: data['placa'],
          );
        }).toList();
      } else {
        throw ('Nenhum veículo encontrado para este usuário');
      }
    } catch (e) {
      print('Erro ao recuperar veículos: $e');
      return [];
    }
  }

  Future<void> atualizarVeiculo(Veiculo veiculo) async {
    try {
      await _veiculosCollection.doc(veiculo.id).update({
        'modelo': veiculo.modelo,
        'marca': veiculo.marca,
        'cor': veiculo.cor,
        'ano': veiculo.ano,
        'usuarioId': veiculo.usuarioId,
        'placa': veiculo.placa
      });
    } catch (e) {
      print('Erro ao atualizar veículo: $e');
    }
  }
}
