import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/DAO/AvaliacaoDAO.dart';
import 'package:uff_caronas/model/DAO/UsuarioDAO.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late AvaliacaoDAO avaliacaoDAO;
  late UsuarioDAO usuarioDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    avaliacaoDAO = AvaliacaoDAO.comFirestore(firestore: firestore);
    usuarioDAO = UsuarioDAO.comFirestore(firestore: firestore);
  });

  test('Comportamento fazer avaliação', () async {

    var passageiro1 = Usuario(nome: 'nome', email: 'email', id: 'id', fotoUrl: 'fotoUrl');
    var passageiro2 = Usuario(nome: 'nome2', email: 'email2', id: 'id2', fotoUrl: 'fotoUrl');

    usuarioDAO.salvarUsuario(passageiro1.id, passageiro1.nome, passageiro1.email, passageiro1.fotoUrl);
    usuarioDAO.salvarUsuario(passageiro2.id, passageiro2.nome, passageiro2.email, passageiro2.fotoUrl);

    var passageiros = [
      passageiro1,
      passageiro2,
    ];

    var notas = [5, 4];
    var comentarios = ['Bom', 'Muito bom'];
    var notasBool = [true, true];
    var comentariosBool = [true, true];
    var isMotorista = false;

    if (notasBool.every((element) => element == true) && comentariosBool.every((element) => element == true)) {
      for (int i = 0; i < passageiros.length; i++) {
        avaliacaoDAO.salvarAvaliacao2(
            passageiros[i].id,
            isMotorista,
            passageiros[i].nome,
            notas[i],
            comentarios[i]
        );
      }
    }

    var avaliacao1 = await avaliacaoDAO.resgataAvaliacoes(passageiro1.id, false);
    var avaliacao2 = await avaliacaoDAO.resgataAvaliacoes(passageiro2.id, false);

    expect(avaliacao1, isNotNull);
    expect(avaliacao2, isNotNull);
  });
}
