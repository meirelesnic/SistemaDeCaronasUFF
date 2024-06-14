import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uff_caronas/model/modelos/Avaliacao.dart';

class AvaliacaoDAO{

  static Future<void> criarOuVerificarAvaliacao(List<String> ids, String caronaId) async {
    try {
      CollectionReference avaliacoesCollection = FirebaseFirestore.instance.collection('controleAvaliacoes');

  
      QuerySnapshot query = await avaliacoesCollection.where('caronaId', isEqualTo: caronaId).get();
      if (query.docs.isNotEmpty) {
        return;
      }

      Map<String, dynamic> data = {
        'caronaId': caronaId,
        ...Map<String, bool>.fromIterable(ids, key: (id) => id, value: (_) => false),
      };

      DocumentReference novoDocumento = await avaliacoesCollection.add(data);
    } catch (e) {
      print('Erro ao criar ou verificar avaliação: ${e.toString()}');
    }
  }

  static Future<bool> usuarioAvaliouCarona(String userId, String caronaId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('controleAvaliacoes')
          .where('caronaId', isEqualTo: caronaId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      DocumentSnapshot snapshot = querySnapshot.docs.first;
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data == null || !data.containsKey(userId)) {
        return false;
      }

      return data[userId] ?? false;
    } catch (e) {
      print('Erro ao verificar se o usuário avaliou a carona: $e');
      return false;
    }
  }

  static Future<void> definirAvaliacaoUsuario(String userId, String caronaId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('controleAvaliacoes')
          .where('caronaId', isEqualTo: caronaId)
          .get();

      // Se não houver documentos correspondentes, cria um novo documento
      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('controleAvaliacoes').doc(caronaId).set({ 'caronaId': caronaId });
      }

      DocumentReference docRef = querySnapshot.docs.first.reference;
      await docRef.update({ userId: true });

      print('Avaliação do usuário atualizada com sucesso!');
    } catch (e) {
      print('Erro ao definir avaliação do usuário: $e');
    }
  }


  static Future<List<Avaliacao>> resgatarAvaliacoes(String userId, bool isMotorista) async {
    List<Avaliacao> avaliacoes = [];

    try {
      String subcolecaoPath = isMotorista ? 'motorista' : 'passageiro';

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('avaliacoes')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return avaliacoes; 
      }

      DocumentReference docRef = querySnapshot.docs.first.reference;

      CollectionReference subcolecao = docRef.collection(subcolecaoPath);

      QuerySnapshot subQuerySnapshot = await subcolecao.get();

      for (var doc in subQuerySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Avaliacao avaliacao = Avaliacao.fromMap(data);
        avaliacoes.add(avaliacao);
      }
    } catch (e) {
      print("Erro ao resgatar avaliações: $e");
    }

    return avaliacoes;
  }

  static Future<void> salvarAvaliacao(String userId, bool isMotorista, String autor, int nota, String comentario) async {
    try {
      String subcolecaoPath = isMotorista ? 'motorista' : 'passageiro';
      print(userId);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('avaliacoes')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('Nenhum documento encontrado para o userID fornecido. Salvar Avaliacao');
        return;
      }

      DocumentReference docRef = querySnapshot.docs.first.reference;
      CollectionReference subcolecao = docRef.collection(subcolecaoPath);

      await subcolecao.add({
        'autor': autor,
        'nota': nota,
        'comentario': comentario,
      });
      print('Avaliacao SALVA');

      await _atualizarMedia(docRef, subcolecaoPath, isMotorista);
    } catch (e) {
      print("Erro ao salvar avaliação: $e");
    }
  }

 static Future<void> _atualizarMedia(DocumentReference docRef, String subcolecaoPath, bool isMotorista) async {
    CollectionReference subcolecao = docRef.collection(subcolecaoPath);
    QuerySnapshot subQuerySnapshot = await subcolecao.get();

    int totalNotas = 0;
    int numeroAvaliacoes = subQuerySnapshot.docs.length;

    for (var doc in subQuerySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['nota'] != null && data['nota'] is int) {
        totalNotas += data['nota'] as int;
      }
    }

    double media = numeroAvaliacoes > 0 ? totalNotas / numeroAvaliacoes : 0;

    if (isMotorista) {
      await docRef.update({'mediaMotorista': media});
    } else {
      await docRef.update({'mediaPassageiro': media});
    }
  }

  static Future<double> getMedia(String userId, bool isMotorista) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('avaliacoes')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return 0.0;
      }

      DocumentSnapshot docSnapshot = querySnapshot.docs.first;

      double media;
      if (isMotorista) {
        media = (docSnapshot['mediaMotorista'] ?? 0).toDouble();
      } else {
        media = (docSnapshot['mediaPassageiro'] ?? 0).toDouble();
      }
      return double.parse(media.toStringAsFixed(2));
    } catch (e) {
      print("Erro ao obter a média: $e");
      return 0.0;
    }
  }

  static Future<void> verificarECriarDocumento(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('avaliacoes')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('avaliacoes').add({
          'userId': userId,
          'mediaMotorista': 5,
          'mediaPassageiro': 5,
        });
        
      } else {
        print('Documento já existe para o userID: $userId');
      }
    } catch (e) {
      print("Erro ao verificar/criar documento: $e");
    }
  }
//===============================================================================
  

//   static Future<List<String>> recuperarTodosUsuarios() async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('usuarios').get();
//     List<String> userIds = querySnapshot.docs.map((doc) => doc['id'] as String).toList();
//     return userIds;
//   } catch (e) {
//     print('Erro ao recuperar IDs de usuários: $e');
//     return [];
//   }
// }

//  static Future<void> gerarAvaliacoesAleatorias(String userId) async {
//   final random = Random();
//   final avaliacaoDAO = AvaliacaoDAO();
//   List<String> nomesAutores = [
//   'João Silva', 'Maria Souza', 'Carlos Pereira', 'Ana Oliveira', 
//   'Paulo Rodrigues', 'Fernanda Lima', 'Lucas Almeida', 'Juliana Gomes'
// ];

// List<String> comentarios = [
//   'Muito bom!', 'Excelente serviço.', 'Recomendo!', 'Muito atencioso.', 
//   'Foi uma ótima experiência.', 'Gostei muito.', 'Tudo perfeito.'
// ];
  
//   // Verificar e criar documento de avaliação se não existir
//   await AvaliacaoDAO.verificarECriarDocumento(userId);

//   // Gerar avaliações para motorista
//   for (int i = 0; i < 3 + random.nextInt(4); i++) {
//     await AvaliacaoDAO.salvarAvaliacao(
//       userId,
//       true,  // isMotorista
//       nomesAutores[random.nextInt(nomesAutores.length)],
//       4 + random.nextInt(2),  // Nota entre 4 e 5
//       comentarios[random.nextInt(comentarios.length)],
//     );
//   }

//   // Gerar avaliações para passageiro
//   for (int i = 0; i < 3 + random.nextInt(4); i++) {
//     await AvaliacaoDAO.salvarAvaliacao(
//       userId,
//       false,  // Não é motorista
//       nomesAutores[random.nextInt(nomesAutores.length)],
//       4 + random.nextInt(2),  // Nota entre 4 e 5
//       comentarios[random.nextInt(comentarios.length)],
//     );
//   }
// }

// static Future<void> gerarAvaliacoesParaTodosUsuarios() async {
//   List<String> userIds = await recuperarTodosUsuarios();
  
//   for (String userId in userIds) {
//     await gerarAvaliacoesAleatorias(userId);
//   }
// }


}