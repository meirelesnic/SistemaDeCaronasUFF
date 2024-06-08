import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/Mensagem.dart';
import '../modelos/chatGrupo.dart';

class ChatGrupoDAO {
  final CollectionReference _chatGrupoCollection =
      FirebaseFirestore.instance.collection('chatGrupo');

  Future<ChatGrupo?> getChatGrupoById(String docId) async {
    DocumentSnapshot docSnapshot = await _chatGrupoCollection.doc(docId).get();

    if (docSnapshot.exists) {
      return ChatGrupo.fromMap(docSnapshot.id, docSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<ChatGrupo>> getChatGruposByUserId(String userId) async {
    print(userId);
    QuerySnapshot querySnapshot = await _chatGrupoCollection
        .where('membersId', arrayContains: userId)
        .get();

    List<ChatGrupo> grupos = querySnapshot.docs.map((doc) {
      return ChatGrupo.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();

    return grupos;
  }

  Stream<List<ChatGrupo>> getChatGruposStreamByUserId(String userId) {
    return _chatGrupoCollection
        .where('membersId', arrayContains: userId)
        .orderBy('ultimaMensagem.hora', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ChatGrupo.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Mensagem>>? getMensagensStream(String docId) {
    return _chatGrupoCollection
        .doc(docId)
        .collection("Mensagens")
        .orderBy('hora', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.map((doc) {
        print(doc.data());
        return Mensagem.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> sendMessage(String docId, String text, String userName, String userId) async {
    var time = FieldValue.serverTimestamp();
    final mensagem = {
      'text': text,
      'hora': time,
      'userName': userName,
      'userId': userId,
    };

    await _chatGrupoCollection
        .doc(docId)
        .collection('Mensagens')
        .add(mensagem);

    await _chatGrupoCollection
        .doc(docId)
        .update({
      'ultimaMensagem': {
        'hora': time,
        'mensagem': text,
      },
      'mensagensTotais': FieldValue.increment(1),
    });
  }

}
