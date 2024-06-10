import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uff_caronas/controller/UsuarioController.dart';
import 'package:uff_caronas/model/DAO/UsuarioDAO.dart';
import 'package:uff_caronas/model/modelos/Usuario.dart';
import '../modelos/Carona.dart';
import '../modelos/Mensagem.dart';
import '../modelos/chatGrupo.dart';

class ChatGrupoDAO {
  final CollectionReference _chatGrupoCollection =
      FirebaseFirestore.instance.collection('chatGrupo');

  Future<void> createNewChat(String id, String nomeChat) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('chatGrupo');

    Timestamp now = Timestamp.now();

    Map<String, dynamic> data = {
      "id": id,
      "members": {},
      "mensagensTotais": 0,
      "membersId": [],
      "ultimaMensagem": {
        "mensagem": "nenhuma mensagem",
        "hora": now
      },
      "nomeChat": nomeChat,
    };

   await collectionRef.add(data);
  }

  Future<void> addMemberToChat(String caronaId, String userId, String username) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('chatGrupo');

    QuerySnapshot querySnapshot = await collectionRef.where('id', isEqualTo: caronaId).get();
    var docId;
    if (querySnapshot.docs.isNotEmpty) {
      docId = querySnapshot.docs.first.id;
    }
    DocumentReference docRef = FirebaseFirestore.instance.collection('chatGrupo').doc(docId);

    Map<String, dynamic> memberData = {
      "readCount": 0,
      "username": username
    };

    await docRef.update({
      "members.$userId": memberData,
      "membersId": FieldValue.arrayUnion([userId])
    });
  }

  void markAsRead(String userId, String docId) async {
    DocumentSnapshot docSnapshot = await _chatGrupoCollection.doc(docId).get();
    int value = docSnapshot.get('mensagensTotais');
    //print(value);
    await _chatGrupoCollection
        .doc(docId)
        .update({
          'members.$userId.readCount': value
        });
    //print("read");
  }

  Future<ChatGrupo?> getChatGrupoById(String docId) async {
    DocumentSnapshot docSnapshot = await _chatGrupoCollection.doc(docId).get();

    if (docSnapshot.exists) {
      return ChatGrupo.fromMap(docSnapshot.id, docSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
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
        //print(doc.data());
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

  void chatParaCaronasAntigas() async {
    CollectionReference _caronasCollection =
      FirebaseFirestore.instance.collection('caronas');
      List<String> passageiro = [];
      UsuarioController u = UsuarioController();
      QuerySnapshot querySnapshot = await _caronasCollection
          .get();

      List<String> caronas = [];
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        caronas.add(snapshot.id);
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        
        if (data != null) {
         
          Usuario? us = await u.recuperarUsuario(data['motoristaId']);
          
          String motoName = us!.nome.split(' ').first;
         // print(motoName);
          String nomeChat ='';

          nomeChat += 'Carona ${motoName} - ${data['data']} - ${data['hora']}';
          print(nomeChat);
          passageiro.add(data['motoristaId']);
          passageiro.addAll(List<String>.from(data['passageirosIds']));
          print('${passageiro.length} passageiros (${snapshot.id})');
          //criar carona docId
          await createNewChat(snapshot.id, nomeChat);
          //Future.delayed(Duration(seconds: 1));
          for(var p in passageiro){
            us = await u.recuperarUsuario(p);
            await addMemberToChat(snapshot.id, p, us!.nome);
            print(' -$p');
          }
          passageiro.clear();
        }
        
      }

    // print(caronas);
       print(caronas.length);
  }

}
