import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<void> getAvaliacoesPassageiro(String userId) async {
    try{
      CollectionReference avaliacoesCollection = FirebaseFirestore.instance.collection('avaliacoes');
      
    } catch (e){
      print('ERRO ${e.toString()}');
    }
  }

}