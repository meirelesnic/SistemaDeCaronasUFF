import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/DAO/PedidoDAO.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late PedidoDAO pedidoDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    pedidoDAO = PedidoDAO.comFirestore(firestore: firestore);
  });

  test('recuperarPedidosPorUsuario retorna lista de pedidos se encontrados', () async {
    await firestore.collection('pedidos').add({
      'data': DateTime.now().toIso8601String(),
      'nomeOrigem': 'Origem',
      'nomeDestino': 'Destino',
      'origem': [1.0, 2.0],
      'destino': [3.0, 4.0],
      'usuario': 'user_id',
      'status': 'pendente',
    });

    final pedidos = await pedidoDAO.recuperarPedidosPorUsuario('user_id');

    expect(pedidos.length, 1);
    expect(pedidos[0]?.nomeOrigem, 'Origem');
    expect(pedidos[0]?.nomeDestino, 'Destino');
    expect(pedidos[0]?.data, isA<String>());
  });

  test('recuperarPedidosPorUsuario retorna lista vazia se nenhum pedido encontrado', () async {
    final pedidos = await pedidoDAO.recuperarPedidosPorUsuario('user_nao_existente');

    expect(pedidos.isEmpty, true);
  });

  test('atualizarStatusPedido atualiza o status de um pedido', () async {
    var docRef = await firestore.collection('pedidos').add({
      'data': DateTime.now().toIso8601String(),
      'nomeOrigem': 'Origem',
      'nomeDestino': 'Destino',
      'origem': [1.0, 2.0],
      'destino': [3.0, 4.0],
      'usuario': 'user_id',
      'status': 'pendente',
    });

    await pedidoDAO.atualizarStatusPedido(docRef.id, 'concluido');

    var updatedDoc = await firestore.collection('pedidos').doc(docRef.id).get();
    var updatedData = updatedDoc.data()!;

    expect(updatedData['status'], 'concluido');
  });

}