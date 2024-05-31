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
      int userId) async {
    try {
      String id = _gerarId();

      await _pedidosCollection.add({
        'id': id,
        'data': data,
        'destino': coordenadasDestino,
        'origem': coordenadasOrigem,
        'nomeOrigem': nomeOrigem,
        'nomeDestino': nomeDestino,
        'usuarioId': userId
      });
    } catch (e) {
      print('Erro ao salvar pedido: $e');
    }
  }

  // Método para obter todos os pedidos de um usuário
  Future<List<Pedido>> recuperarPedidos(String id) async {
    try {
      List<Pedido> pedidos = [];
      QuerySnapshot querySnapshot =
          await _pedidosCollection.where('usuarioId', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot snapshot in querySnapshot.docs) {
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
          if (data != null) {
            pedidos.add(Pedido(
              id: snapshot.id,
              data: data['data'],
              nomeOrigem: data['nomeOrigem'],
              nomeDestino: data['nomeDestino'],
              coordenadasOrigem: data['origem'],
              coordenadasDestino: data['destino'],
              usuario: data['usuarioId'],
            ));
          } else {
            throw ('Dados do pedido são nulos');
          }
        }
      } else {
        throw ('Pedido não encontrado');
      }
      return pedidos;
    } catch (e) {
      print('Erro ao recuperar pedido: $e');
      return [];
    }
  }
}
