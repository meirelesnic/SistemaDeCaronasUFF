import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:uff_caronas/model/DAO/ChatGrupoDAO.dart';
import 'package:async/async.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late ChatGrupoDAO chatGrupoDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    chatGrupoDAO = ChatGrupoDAO.comFirestore(firestore: firestore);

  });

  test('Criar novo chat no Firestore falso', () async {
    await chatGrupoDAO.createNewChat('1', 'Chat Teste');

    QuerySnapshot querySnapshot = await firestore.collection('chatGrupo').get();
    List<DocumentSnapshot> docs = querySnapshot.docs;

    expect(docs.length, 1);

    Map<String, dynamic>? chatData = docs[0].data() as Map<String, dynamic>?;
    expect(chatData, isNotNull);

    expect(chatData!['id'], '1');
    expect(chatData['nomeChat'], 'Chat Teste');
  });


  test('getChatGrupoById retorna ChatGrupo se encontrado', () async {
    await firestore.collection('chatGrupo').doc('test_id').set({
      'id': 'test_id',
    });

    final chatGrupo = await chatGrupoDAO.getChatGrupoById('test_id');

    expect(chatGrupo, isNotNull);
    expect(chatGrupo?.id, 'test_id');
  });

  test('getChatGrupoById retorna null se não encontrado', () async {
    final chatGrupo = await chatGrupoDAO.getChatGrupoById('non_existing_id');

    expect(chatGrupo, isNull);
  });

  test('getChatGruposStreamByUserId retorna um stream de ChatGrupo se encontrados', () async {
    await firestore.collection('chatGrupo').add({
      'id': 'chat_1',
      'membersId': ['user_1'],
      'ultimaMensagem': {'hora': Timestamp.now()}
    });

    await firestore.collection('chatGrupo').add({
      'id': 'chat_2',
      'membersId': ['user_1', 'user_2'],
      'ultimaMensagem': {'hora': Timestamp.now()}
    });

    final stream = chatGrupoDAO.getChatGruposStreamByUserId('user_1');
    final streamQueue = StreamQueue(stream);

    final chatGrupos = await streamQueue.next;
    expect(chatGrupos.length, 2);
  });

  test('getChatGruposStreamByUserId retorna um stream vazio se nenhum encontrado', () async {
    final stream = chatGrupoDAO.getChatGruposStreamByUserId('user_non_existent');
    final streamQueue = StreamQueue(stream);

    final chatGrupos = await streamQueue.next;
    expect(chatGrupos.isEmpty, true);
  });

  test('getMensagensStream retorna um stream vazio se nenhuma mensagem encontrada', () async {
    final stream = chatGrupoDAO.getMensagensStream('non_existing_chat');
    final streamQueue = StreamQueue(stream!);

    final mensagens = await streamQueue.next;
    expect(mensagens.isEmpty, true);
  });
}