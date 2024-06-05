import 'package:uff_caronas/model/DAO/PedidoPassageiroDAO.dart';
import 'package:uff_caronas/model/modelos/Carona.dart';
import 'package:uff_caronas/model/modelos/PedidoPassageiro.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';

class PedidoPassageiroController {
  PedidoPassageiroDAO? pedidoPassageiroDAO;

  PedidoPassageiroController() {
    pedidoPassageiroDAO = PedidoPassageiroDAO();
  }

  void criarPedidoPassageiro(
      String userId, String motoristaId, String caronaId, String status) {
    pedidoPassageiroDAO?.salvarPedidoPassageiro(
        userId, motoristaId, caronaId, status);
  }

  void aceitarPassageiro(String id) {
    pedidoPassageiroDAO?.aceitarPassageiro(id);
  }

  void recusarPassageiro(String id) {
    pedidoPassageiroDAO?.recusarPassageiro(id);
  }

  void cancelarPassageiro(String id) {
    pedidoPassageiroDAO?.cancelarPedidoPassageiro(id);
  }

  Future<List<PedidoPassageiro>>? recuperarPassageirosPendentesPorUsuario(
      String motoristaId) {
    return pedidoPassageiroDAO!
        .recuperarPassageirosPendentesPorUsuario(motoristaId);
  }

  Future<Map<Carona?, List<PedidoPassageiro?>>> recuperarCaronasComPedidos(
      List<PedidoPassageiro> pedidosPassageiro) {
    return pedidoPassageiroDAO!.recuperarCaronasComPedidos(pedidosPassageiro);
  }

  atalizarPedidosPassageiroExpirados(List<PedidoPassageiro> pedidosPassageiro) {
    pedidoPassageiroDAO!.atualizarPedidosPassageiroExpirados(pedidosPassageiro);
  }
}
