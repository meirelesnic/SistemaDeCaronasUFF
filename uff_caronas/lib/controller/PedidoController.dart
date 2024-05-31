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
      int userId) {
    pedidoDAO?.salvarPedido(
        data, nomeOrigem, nomeDestino, coordenadasOrigem, coordenadasDestino, userId);
  }

  Future<List<Pedido>> recuperarPedidos(String id) {
    return pedidoDAO!.recuperarPedidos(id);
  }
}
