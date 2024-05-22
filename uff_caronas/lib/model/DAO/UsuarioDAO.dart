import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/Usuario.dart';

class UsuarioDAO {
  final CollectionReference _usuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  Future<void> salvarUsuario(
      String id, String nome, String email, String fotoUrl) async {
    try {
      await _usuariosCollection
          .add({'id': id, 'nome': nome, 'email': email, 'fotoUrl': fotoUrl});
    } catch (e) {
      print('Erro ao salvar usuario: $e');
    }
  }

  Future<Usuario?> recuperarUsuario(String id) async {
    try {
      QuerySnapshot querySnapshot =
          await _usuariosCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return Usuario(
            id: snapshot.id,
            nome: data['nome'],
            email: data['email'],
            fotoUrl: data['fotoUrl'],
          );
        } else {
          throw ('Dados do usuario são nulos');
        }
      } else {
        throw ('Usuario não encontrado');
      }
    } catch (e) {
      print('Erro ao recuperar usuario: $e');
      return null;
    }
  }

  Future<void> editarUsuario(String id, String novoNome) async {
    try {
      var querySnapshot =
          await _usuariosCollection.where('id', isEqualTo: id).get();
      await _usuariosCollection
          .doc(querySnapshot.docs.first.id)
          .update({'nome': novoNome});
    } catch (e) {
      print('Erro ao atualizar o nome do usuário: $e');
    }
  }

  Future<bool> usuarioExiste(String id) async {
    try {
      QuerySnapshot querySnapshot =
          await _usuariosCollection.where('id', isEqualTo: id).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Erro ao verificar se usuário existe: $e');
      return false;
    }
  }
}
