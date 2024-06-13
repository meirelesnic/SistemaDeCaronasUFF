import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/DAO/UsuarioDAO.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late UsuarioDAO usuarioDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    usuarioDAO = UsuarioDAO.comFirestore(firestore: firestore);
  });

  test('Teste de salvar usuário', () async {
    await usuarioDAO.salvarUsuario('id', 'nome', 'email', 'fotoUrl');

    final usuario = await usuarioDAO.recuperarUsuario('id');
    expect(usuario?.nome, 'nome');
    expect(usuario?.email, 'email');
    expect(usuario?.fotoUrl, 'fotoUrl');
  });

  test('Teste de recuperar usuário existente', () async {
    await usuarioDAO.salvarUsuario('id', 'nome', 'email', 'fotoUrl');

    final usuario = await usuarioDAO.recuperarUsuario('id');
    expect(usuario?.nome, 'nome');
    expect(usuario?.email, 'email');
    expect(usuario?.fotoUrl, 'fotoUrl');
  });


  test('Teste de recuperar usuário inexistente', () async {
    final usuario = await usuarioDAO.recuperarUsuario('id_inexistente');
    expect(usuario, isNull);
  });

  test('Teste de editar usuário', () async {
    await usuarioDAO.salvarUsuario('id', 'nome', 'email', 'fotoUrl');
    await usuarioDAO.editarUsuario('id', 'novo_nome');

    final usuario = await usuarioDAO.recuperarUsuario('id');
    expect(usuario?.nome, 'novo_nome');
  });

  test('Teste de verificar se usuário existe', () async {
    await usuarioDAO.salvarUsuario('id', 'nome', 'email', 'fotoUrl');

    final usuarioExiste = await usuarioDAO.usuarioExiste('id');
    expect(usuarioExiste, true);
  });

  test('Teste de verificar se usuário não existe', () async {
    final usuarioExiste = await usuarioDAO.usuarioExiste('id_inexistente');
    expect(usuarioExiste, false);
  });

}
