import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/Usuario.dart';

class UsuarioDAO {
  final CollectionReference<Map<String, dynamic>> _usuariosCollection;

  UsuarioDAO() : _usuariosCollection = FirebaseFirestore.instance.collection('usuarios');

  UsuarioDAO.comFirestore({FirebaseFirestore? firestore})
      : _usuariosCollection = (firestore ?? FirebaseFirestore.instance).collection('usuarios');

  Future<void> salvarUsuario(String id, String nome, String email, String fotoUrl) async {
    try {
      await _usuariosCollection.doc(id).set({
        'id': id,
        'nome': nome,
        'email': email,
        'fotoUrl': fotoUrl,
      });
    } catch (e) {
      print('Erro ao salvar usuário: $e');
    }
  }

  Future<Usuario?> recuperarUsuario(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _usuariosCollection.doc(id).get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();
        if (data != null) {
          return Usuario(
            id: snapshot.id,
            nome: data['nome'],
            email: data['email'],
            fotoUrl: data['fotoUrl'],
          );
        } else {
          throw Exception('Dados do usuário são nulos');
        }
      } else {
        throw Exception('Usuário não encontrado');
      }
    } catch (e) {
      print('Erro ao recuperar usuário: $e');
      return null;
    }
  }

  Future<void> editarUsuario(String id, String novoNome) async {
    try {
      await _usuariosCollection.doc(id).update({'nome': novoNome});
    } catch (e) {
      print('Erro ao atualizar o nome do usuário: $e');
    }
  }

  Future<bool> usuarioExiste(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _usuariosCollection.doc(id).get();
      return snapshot.exists;
    } catch (e) {
      print('Erro ao verificar se usuário existe: $e');
      return false;
    }
  }
}
