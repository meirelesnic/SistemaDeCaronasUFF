
import '../model/DAO/VeiculoDAO.dart';
import '../model/modelos/Veiculo.dart';

class VeiculoController {
  VeiculoDAO? veiculoDAO;

  VeiculoController() {
    veiculoDAO = VeiculoDAO();
  }

  void salvarVeiculo(String modelo, String marca, String cor, int ano, String userId, String placa) {
    veiculoDAO?.salvarVeiculo(modelo, marca, cor, ano, userId, placa);
  }

  void editarVeiculo(Veiculo veiculo) {
    veiculoDAO?.atualizarVeiculo(veiculo);
  }

  Future<List<Veiculo>>? veiculosPorUsuarioId(String id){
    return veiculoDAO?.recuperarVeiculosPorUsuario(id);
  }
}