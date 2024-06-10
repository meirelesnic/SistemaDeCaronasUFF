import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/DAO/UsuarioDAO.dart';

import '../../../firebase_options.dart';

void main() async {
  late UsuarioDAO usuarioDAO;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUp(() {
    usuarioDAO = UsuarioDAO();
  });

  group('UsuarioDAO', () {

    test('Salvar usuário', () async {
      await usuarioDAO.salvarUsuario('1', 'Teste', 'teste@teste.com', 'url');
      var usuario = await usuarioDAO.recuperarUsuario('1');
      expect(usuario!.nome, 'Teste');
      expect(usuario.email, 'teste@teste.com');
      expect(usuario.fotoUrl, 'url');
    });

    test('Recuperar usuário', () async {
      var usuario = await usuarioDAO.recuperarUsuario('1');
      expect(usuario, isNotNull);
      expect(usuario!.id, '1');
      expect(usuario.nome, 'Teste');
      expect(usuario.email, 'teste@teste.com');
      expect(usuario.fotoUrl, 'url');
    });

    test('Editar usuário', () async {
      await usuarioDAO.editarUsuario('1', 'Novo Nome');
      var usuario = await usuarioDAO.recuperarUsuario('1');
      expect(usuario!.nome, 'Novo Nome');
    });

    test('Verificar se usuário existe', () async {
      var existe = await usuarioDAO.usuarioExiste('1');
      expect(existe, isTrue);

      existe = await usuarioDAO.usuarioExiste('2');
      expect(existe, isFalse);
    });
  });
}
