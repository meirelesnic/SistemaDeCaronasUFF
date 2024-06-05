import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uff_caronas/controller/CaronaController.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/model/modelos/PedidoPassageiro.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';

class PedidoPassageiroDAO {
  final CollectionReference _pedidoPassageiroCollection =
      FirebaseFirestore.instance.collection('pedidoPassageiro');

  String _gerarId() {
    var random = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  Future<void> salvarPedidoPassageiro(
      String userId, String motoristaId, String caronaId, String status) async {
    try {
      String id = _gerarId();

      await _pedidoPassageiroCollection.add({
        'id': id,
        'userId': userId,
        'motoristaId': motoristaId,
        'caronaId': caronaId,
        'status': status,
      });
    } catch (e) {
      print('Erro ao salvar pedido: $e');
    }
  }

  Future<List<PedidoPassageiro>> recuperarPassageirosPendentesPorUsuario(
      String motoristaId) async {
    List<PedidoPassageiro> pedidosPassageiro = [];
    try {
      QuerySnapshot querySnapshot = await _pedidoPassageiroCollection
          .where('motoristaId', isEqualTo: motoristaId)
          .where('status', isEqualTo: 'Pendente')
          .get();
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          pedidosPassageiro.add(PedidoPassageiro(
            id: snapshot.id,
            userId: data['userId'],
            motoristaId: data['motoristaId'],
            caronaId: data['caronaId'],
            status: data['status'],
          ));
        } else {
          throw ('Dados do pedido são nulos');
        }
      }
      return pedidosPassageiro;
    } catch (e) {
      print('Erro ao recuperar passageiros: $e');
      return [];
    }
  }

  Future<Map<Carona?, List<PedidoPassageiro?>>> recuperarCaronasComPedidos(
      List<PedidoPassageiro> pedidosPassageiro) async {
    try {
      Map<Carona?, List<PedidoPassageiro?>> caronaPassageirosMap = {};
      for (int i = 0; i < pedidosPassageiro.length; i++) {
        Carona? carona = await CaronaController()
            .recuperarCaronaPorId(pedidosPassageiro[i].caronaId);
        // Usuario? usuario = await UsuarioController()
        //     .recuperarUsuario(pedidosPassageiro[i].userId);
        if (carona != null) {
          if (caronaPassageirosMap.containsKey(carona)) {
            caronaPassageirosMap[carona]!.add(pedidosPassageiro[i]);
          } else {
            caronaPassageirosMap[carona] = [pedidosPassageiro[i]];
          }
        } else {
          throw ('Carona ou usuário não encontrados');
        }
      }
      return caronaPassageirosMap;
    } catch (e) {
      print('Erro ao recuperar passageiros por carona: $e');
      return {};
    }
  }

  Future<void> aceitarPassageiro(String id) async {
    try {
      await _pedidoPassageiroCollection.doc(id).update({'status': 'Aceito'});
    } catch (e) {
      print('Erro ao aceitar passageiro: $e');
    }
  }

  Future<void> recusarPassageiro(String id) async {
    try {
      await _pedidoPassageiroCollection.doc(id).update({'status': 'Recusado'});
    } catch (e) {
      print('Erro ao recusar passageiro: $e');
    }
  }

  Future<void> cancelarPedidoPassageiro(String id) async {
    try {
      await _pedidoPassageiroCollection.doc(id).update({'status': 'Cancelado'});
    } catch (e) {
      print('Erro ao cancelar passageiro: $e');
    }
  }

  Future<void> atualizarPedidosPassageiroExpirados(
      List<PedidoPassageiro> pedidosPassageiro) async {
    DateFormat format = DateFormat("dd/MM/yyyy - HH:mm");

    // Subtraindo somente 2 horas para dar um período de tolerância de 1 hora
    DateTime now = DateTime.now().subtract(Duration(hours: 2));

    for (int i = 0; i < pedidosPassageiro.length; i++) {
      if (pedidosPassageiro[i].status == 'Pendente') {
        Carona? carona = await CaronaController()
            .recuperarCaronaPorId(pedidosPassageiro[i].caronaId);

        if (carona != null) {
          DateTime dataCarona =
              format.parse(carona!.data + ' - ' + carona.hora);
          if (dataCarona.isBefore(now)) {
            await _pedidoPassageiroCollection
                .doc(pedidosPassageiro[i].id)
                .update({'status': 'Expirado'});
          }
        }
      }
    }
  }
}
