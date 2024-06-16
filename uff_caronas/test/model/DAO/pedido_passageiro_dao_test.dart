import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/DAO/PedidoPassageiroDAO.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:uff_caronas/model/modelos/PedidoPassageiro.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late PedidoPassageiroDAO pedidoPassageiroDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    pedidoPassageiroDAO =
        PedidoPassageiroDAO.comFirestore(firestore: firestore);
  });
    test(
        'recuperarPassageirosPendentesPorUsuario retorna lista de pedidos pendentes se encontrados', () async {
      await firestore.collection('pedidoPassageiro').add({
        'userId': 'user_1',
        'motoristaId': 'motorista_1',
        'caronaId': 'carona_1',
        'status': 'Pendente',
      });

      await firestore.collection('pedidoPassageiro').add({
        'userId': 'user_2',
        'motoristaId': 'motorista_1',
        'caronaId': 'carona_2',
        'status': 'Pendente',
      });

      await firestore.collection('pedidoPassageiro').add({
        'userId': 'user_3',
        'motoristaId': 'motorista_1',
        'caronaId': 'carona_3',
        'status': 'Aceito',
      });

      final pedidos = await pedidoPassageiroDAO
          .recuperarPassageirosPendentesPorUsuario('motorista_1');

      expect(pedidos.length, 2);
      expect(pedidos[0].motoristaId, 'motorista_1');
      expect(pedidos[0].status, 'Pendente');
      expect(pedidos[1].motoristaId, 'motorista_1');
      expect(pedidos[1].status, 'Pendente');
    });

    test(
        'recuperarPassageirosPendentesPorUsuario retorna lista vazia se nenhum pedido pendente encontrado', () async {
      await firestore.collection('pedidoPassageiro').add({
        'userId': 'user_3',
        'motoristaId': 'motorista_2',
        'caronaId': 'carona_3',
        'status': 'Aceito',
      });

      final pedidos = await pedidoPassageiroDAO
          .recuperarPassageirosPendentesPorUsuario('motorista_1');

      expect(pedidos.isEmpty, true);
    });

  test('recuperarCaronasComPedidos retorna mapa vazio quando não há pedidos', () async {
    List<PedidoPassageiro> pedidosPassageiro = [];

    final caronaPassageirosMap = await pedidoPassageiroDAO.recuperarCaronasComPedidos(
      pedidosPassageiro
    );

    expect(caronaPassageirosMap.length, 0);
  });

  test('recuperarPedidoPassageiroPorId retorna pedido correto', () async {
    final pedidoDoc = await firestore.collection('pedidoPassageiro').add({
      'userId': 'user_1',
      'motoristaId': 'motorista_1',
      'caronaId': 'carona_1',
      'status': 'Pendente',
    });

    final pedido = await pedidoPassageiroDAO.recuperarPedidoPassageiroPorId(pedidoDoc.id);

    expect(pedido, isNotNull);
    expect(pedido!.id, pedidoDoc.id);
    expect(pedido.status, 'Pendente');
  });

  test('recuperarPedidoPassageiroPorId retorna null quando pedido não existe', () async {
    final pedido = await pedidoPassageiroDAO.recuperarPedidoPassageiroPorId('non_existing_id');

    expect(pedido, isNull);
  });

  test('aceitarPassageiro atualiza status para Aceito', () async {
    final pedidoDoc = await firestore.collection('pedidoPassageiro').add({
      'userId': 'user_1',
      'motoristaId': 'motorista_1',
      'caronaId': 'carona_1',
      'status': 'Pendente',
    });

    await pedidoPassageiroDAO.aceitarPassageiro(pedidoDoc.id);

    final updatedDoc = await firestore.collection('pedidoPassageiro').doc(pedidoDoc.id).get();
    expect(updatedDoc['status'], 'Aceito');
  });

  test('recusarPassageiro atualiza status para Recusado', () async {
    final pedidoDoc = await firestore.collection('pedidoPassageiro').add({
      'userId': 'user_1',
      'motoristaId': 'motorista_1',
      'caronaId': 'carona_1',
      'status': 'Pendente',
    });

    await pedidoPassageiroDAO.recusarPassageiro(pedidoDoc.id);

    final updatedDoc = await firestore.collection('pedidoPassageiro').doc(pedidoDoc.id).get();
    expect(updatedDoc['status'], 'Recusado');
  });

  test('cancelarPedidoPassageiro atualiza status para Cancelado', () async {
    final pedidoDoc = await firestore.collection('pedidoPassageiro').add({
      'userId': 'user_1',
      'motoristaId': 'motorista_1',
      'caronaId': 'carona_1',
      'status': 'Pendente',
    });

    await pedidoPassageiroDAO.cancelarPedidoPassageiro(pedidoDoc.id);

    final updatedDoc = await firestore.collection('pedidoPassageiro').doc(pedidoDoc.id).get();
    expect(updatedDoc['status'], 'Cancelado');
  });
}
