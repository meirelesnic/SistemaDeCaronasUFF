import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/Pedido.dart';

class PedidoDAO {
  final CollectionReference _pedidosCollection =
      FirebaseFirestore.instance.collection('pedidos');

  String _gerarId() {
    var random = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  Future<void> salvarPedido(
      String data,
      String nomeOrigem,
      String nomeDestino,
      List<double> coordenadasOrigem,
      List<double> coordenadasDestino,
      String userId) async {
    try {
      String id = _gerarId();

      await _pedidosCollection.add({
        'id': id,
        'data': data,
        'destino': coordenadasDestino,
        'origem': coordenadasOrigem,
        'nomeOrigem': nomeOrigem,
        'nomeDestino': nomeDestino,
        'usuario': userId,
        'status': 'Pendente',
      });
    } catch (e) {
      print('Erro ao salvar pedido: $e');
    }
  }

  // Método para obter todos os pedidos de um usuário
  Future<List<Pedido?>> recuperarPedidosPorUsuario(String id) async {
    try {
      List<Pedido> pedidos = [];
      QuerySnapshot querySnapshot =
          await _pedidosCollection.where('usuario', isEqualTo: id).get();

      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          pedidos.add(Pedido(
            id: snapshot.id,
            data: data['data'],
            nomeOrigem: data['nomeOrigem'],
            nomeDestino: data['nomeDestino'],
            coordenadasOrigem: List<double>.from(data['origem']),
            coordenadasDestino: List<double>.from(data['destino']),
            usuario: data['usuario'],
            status: data['status'],
          ));
        } else {
          throw ('Pedido não encontrado');
        }
      }
      return pedidos;
    } catch (e) {
      print('Erro ao recuperar pedido: $e');
      return [];
    }
  }

  Future<void> deletarPedido(String id) async {
    try {
      // await _pedidosCollection
      //     .where('id', isEqualTo: id)
      //     .get()
      //     .then((querySnapshot) {
      //   for (var doc in querySnapshot.docs) {
      //     doc.reference.delete();
      //   }
      // });
      await _pedidosCollection.doc(id).delete();
    } catch (e) {
      print('Erro ao deletar pedido: $e');
    }
  }

  Future<void> atualizarStatusPedido(String id, String status) async {
    try {
      await _pedidosCollection.doc(id).update({'status': status});
    } catch (e) {
      print('Erro ao atualizar status do pedido: $e');
    }
  }
}
