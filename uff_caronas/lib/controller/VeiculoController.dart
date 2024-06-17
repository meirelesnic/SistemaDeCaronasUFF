import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/DAO/VeiculoDAO.dart';
import '../model/modelos/Veiculo.dart';

class VeiculoController {
  VeiculoDAO? veiculoDAO;

  VeiculoController() {
    veiculoDAO = VeiculoDAO();
  }

  VeiculoController.comFirestore({FirebaseFirestore? firestore}) {
    veiculoDAO = VeiculoDAO.comFirestore(firestore: firestore);
  }

  void salvarVeiculo(String modelo, String marca, String cor, int ano,
      String userId, String placa) {
    veiculoDAO?.salvarVeiculo(modelo, marca, cor, ano, userId, placa);
  }

  void editarVeiculo(Veiculo veiculo) {
    veiculoDAO?.atualizarVeiculo(veiculo);
  }

  Future<List<Veiculo>>? veiculosPorUsuarioId(String id) {
    return veiculoDAO?.recuperarVeiculosPorUsuario(id);
  }

  Future<Veiculo?>? recuperarVeiculo(String id) {
    return veiculoDAO?.recuperarVeiculo(id);
  }

  Future<Veiculo?>? recuperarVeiculoDoc(String id) {
    return veiculoDAO?.recuperarVeiculoDoc(id);
  }

  Future<bool>? hasVeiculoIdUser(String userId){
    return veiculoDAO?.hasVeiculoIdUser(userId);
  }

  bool validaAno(int year) {
    int aux = DateTime.now().year;
    if (aux < year || year + 25 < aux) return false;
    return true;
  }

  bool validaPlaca(String placa) {
    if (placa.length != 7) {
      return false;
    }

    for (int i = 0; i < 3; i++) {
      if (!_isLetter(placa[i])) {
        return false;
      }
    }
    if (!_isLetter(placa[4]) && !_isDigit(placa[4])) {
      return false;
    }

    for (int i = 3; i < 7; i = i + 2 - i ~/ 4) {
      if (!_isDigit(placa[i])) {
        return false;
      }
    }

    return true;
  }

  bool _isLetter(String character) {
    return character.toUpperCase() != character.toLowerCase();
  }

  bool _isDigit(String character) {
    return int.tryParse(character) != null;
  }
}
