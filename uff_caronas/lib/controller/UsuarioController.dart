import 'package:uff_caronas/model/DAO/UsuarioDAO.dart';

class UsuarioController {
  UsuarioDAO? usuarioDAO;

  UsuarioController() {
    usuarioDAO = UsuarioDAO();
  }

  void salvarUsuario(String id, String nome, String email, String fotoUrl) {
    usuarioDAO?.salvarUsuario(id, nome, email, fotoUrl);
  }

  void editarUsuario(String id, String novoNome) {
    usuarioDAO?.editarUsuario(id, novoNome);
  }

  Future<bool> usuarioExiste(String id) {
    return usuarioDAO!.usuarioExiste(id);
  }
}
