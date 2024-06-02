import 'package:uff_caronas/model/DAO/PedidoDAO.dart';
import 'package:uff_caronas/model/modelos/Pedido.dart';

class PedidoController {
  PedidoDAO? pedidoDAO;

  PedidoController() {
    pedidoDAO = PedidoDAO();
  }

  void salvarPedido(
      String data,
      String nomeOrigem,
      String nomeDestino,
      List<double> coordenadasOrigem,
      List<double> coordenadasDestino,
      String userId) {
    pedidoDAO?.salvarPedido(data, nomeOrigem, nomeDestino, coordenadasOrigem,
        coordenadasDestino, userId);
  }

  Future<List<Pedido?>> recuperarPedidosPorUsuario(String id) {
    return pedidoDAO!.recuperarPedidosPorUsuario(id);
  }

  Future<void> deletarPedido(String id) {
    return pedidoDAO!.deletarPedido(id);
  }

  Future<void> atualizarStatusPedido(String id, String status) {
    return pedidoDAO!.atualizarStatusPedido(id, status);
  }
}
