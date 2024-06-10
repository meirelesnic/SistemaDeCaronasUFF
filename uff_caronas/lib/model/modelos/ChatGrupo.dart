import 'package:cloud_firestore/cloud_firestore.dart';

class ChatGrupo {
  late String docId; // Adicionando o atributo docId

  late Map<String, dynamic> ultimaMensagem;
  late List<String> membersId;
  late String nomeChat;
  late Map<String, Map<String, dynamic>> members;
  late String id;
  late int mensagensTotais;

  ChatGrupo({
    required this.docId, // Atualizando o construtor para incluir docId
    required this.ultimaMensagem,
    required this.membersId,
    required this.nomeChat,
    required this.members,
    required this.id,
    required this.mensagensTotais,
  });

  // Método para converter a classe em um mapa (para armazenar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'ultimaMensagem': ultimaMensagem,
      'membersId': membersId,
      'nomeChat': nomeChat,
      'members': members,
      'id': id,
      'mensagensTotais': mensagensTotais,
    };
  }

  // Método para criar uma instância da classe a partir de um mapa (para recuperar do Firestore)
  factory ChatGrupo.fromMap(String docId, Map<String, dynamic> map) { // Alterando a assinatura para incluir docId
    return ChatGrupo(
      docId: docId,
      ultimaMensagem: map['ultimaMensagem'] ?? {},
      membersId: List<String>.from(map['membersId'] ?? []),
      nomeChat: map['nomeChat'] ?? '',
      members: Map<String, Map<String, dynamic>>.from(map['members'] ?? {}),
      id: map['id'] ?? '0',
      mensagensTotais: map['mensagensTotais'] ?? 0,
    );
  }
}
