import '../model/DAO/CaronaDAO.dart';
import '../model/modelos/Carona.dart';

class CaronaController {
  CaronaDAO? caronaDAO;

  CaronaController() {
    caronaDAO = CaronaDAO();
  }

  void salvarCarona(
      List<double> origem,
      List<double> dest,
      String origemLocal,
      String origemDestino,
      String data,
      String hora,
      bool autoAceitar,
      String veiculoId,
      int vagas,
      String motoristaId,
      List<String?> passageirosIds,
      ) {
    caronaDAO?.salvarCarona(origem, dest, origemLocal, origemDestino, data, hora, autoAceitar, veiculoId, vagas, motoristaId, passageirosIds);
  }

  

}
