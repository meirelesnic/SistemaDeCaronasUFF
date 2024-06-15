import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uff_caronas/model/DAO/ChatGrupoDAO.dart';
import '../../view/login.dart';
import '../modelos/Carona.dart';
import 'package:intl/intl.dart';

class CaronaDAO {
  final CollectionReference _caronasCollection =
      FirebaseFirestore.instance.collection('caronas');

  String _gerarId() {
    var random = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        random.nextInt(9999).toString().padLeft(4, '0');
  }

  Future<void> salvarCarona(
    List<double> origem,
    List<double> dest,
    String origemLocal,
    String origemDestino,
    String data,
    String hora,
    bool autoAceitar,
    String veiculoId,
    int vagas,
    String motoristaId,
    List<String?> passageirosIds,
  ) async {
    try {
      String id = _gerarId();

      DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateTime dateTime = dateFormat.parse('$data $hora');
      Timestamp timestamp = Timestamp.fromDate(dateTime);

      DocumentReference docRefId = await _caronasCollection.add({
        'id': id,
        'origem': origem,
        'dest': dest,
        'origemLocal': origemLocal,
        'origemDestino': origemDestino,
        'data': data,
        'hora': hora,
        'autoAceitar': autoAceitar,
        'veiculoId': veiculoId,
        'vagas': vagas,
        'motoristaId': motoristaId,
        'passageirosIds': passageirosIds,
        'dataTimestamp': timestamp,
      });
      
      //criar Chat,
      String nomeChat = 'Carona ${user!.nome.split(' ').first} - $data - $hora';
      ChatGrupoDAO _chatGrupoDAO = ChatGrupoDAO();
      await _chatGrupoDAO.createNewChat(docRefId.id, nomeChat);
      //Add motorista no chat
      await _chatGrupoDAO.addMemberToChat(docRefId.id, motoristaId, user!.nome);

    } catch (e) {
      print('Erro ao salvar carona: $e');
    }
  }

  // Future<List<Carona>?> recuperarCaronasComoPassageiro(
  //     String idPassageiro) async {
  //   try {
  //     QuerySnapshot querySnapshot = await _caronasCollection
  //         .where('passageirosIds', arrayContains: idPassageiro)
  //         .get();

  //     List<Carona> caronas = [];
  //     for (DocumentSnapshot snapshot in querySnapshot.docs) {
  //       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

  //       if (data != null) {
  //         Carona carona = Carona(
  //           id: data['id'],
  //           origem: List<double>.from(data['origem']),
  //           dest: List<double>.from(data['dest']),
  //           origemLocal: data['origemLocal'],
  //           origemDestino: data['origemDestino'],
  //           data: data['data'],
  //           hora: data['hora'],
  //           autoAceitar: data['autoAceitar'],
  //           veiculoId: data['veiculoId'],
  //           vagas: data['vagas'],
  //           motoristaId: data['motoristaId'],
  //           passageirosIds: data['passageirosIds'] != null
  //               ? List<String>.from(data['passageirosIds'])
  //               : null,
  //         );
  //         caronas.add(carona);
  //       }
  //     }

  //     return caronas;
  //   } catch (e) {
  //     print('Erro ao recuperar caronas como passageiro: $e');
  //     return null;
  //   }
  // }

  // Future<List<Carona>?> recuperarCaronasComoMotorista(
  //     String idMotorista) async {
  //   try {
  //     QuerySnapshot querySnapshot = await _caronasCollection
  //         .where('motoristaId', isEqualTo: idMotorista)
  //         .get();

  //     List<Carona> caronas = [];
  //     for (DocumentSnapshot snapshot in querySnapshot.docs) {
  //       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

  //       if (data != null) {
  //         Carona carona = Carona(
  //           id: data['id'],
  //           origem: List<double>.from(data['origem']),
  //           dest: List<double>.from(data['dest']),
  //           origemLocal: data['origemLocal'],
  //           origemDestino: data['origemDestino'],
  //           data: data['data'],
  //           hora: data['hora'],
  //           autoAceitar: data['autoAceitar'],
  //           veiculoId: data['veiculoId'],
  //           vagas: data['vagas'],
  //           motoristaId: data['motoristaId'],
  //           passageirosIds: data['passageirosIds'] != null
  //               ? List<String>.from(data['passageirosIds'])
  //               : null,
  //         );
  //         caronas.add(carona);
  //       }
  //     }

  //     return caronas;
  //   } catch (e) {
  //     print('Erro ao recuperar caronas como motorista: $e');
  //     return null;
  //   }
  // }

  Future<List<Carona>> buscarCaronasPorDataEVagas(String data) async {
    try {
      QuerySnapshot querySnapshot = await _caronasCollection
          .where('data', isEqualTo: data)
          .where('vagas', isGreaterThan: 0)
          .orderBy('data')
          .orderBy('hora')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          return Carona(
            id: doc.id,
            origem: List<double>.from(data!['origem']),
            dest: List<double>.from(data['dest']),
            origemLocal: data['origemLocal'],
            origemDestino: data['origemDestino'],
            data: data['data'],
            hora: data['hora'],
            autoAceitar: data['autoAceitar'],
            veiculoId: data['veiculoId'],
            vagas: data['vagas'],
            motoristaId: data['motoristaId'],
            passageirosIds: data['passageirosIds'] != null
                ? List<String>.from(data['passageirosIds'])
                : [],
          );
        }).toList();
      } else {
        throw ('Nenhuma carona encontrada para esta data');
      }
    } catch (e) {
      print('Erro ao buscar caronas por data e vagas: $e');
      return [];
    }
  }

  Future<Carona?> recuperarCaronaPorId(String id) async {
    try {
      QuerySnapshot querySnapshot =
          await _caronasCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return Carona(
            id: snapshot.id,
            origem: List<double>.from(data['origem']),
            dest: List<double>.from(data['dest']),
            origemLocal: data['origemLocal'],
            origemDestino: data['origemDestino'],
            data: data['data'],
            hora: data['hora'],
            autoAceitar: data['autoAceitar'],
            veiculoId: data['veiculoId'],
            vagas: data['vagas'],
            motoristaId: data['motoristaId'],
            passageirosIds: data['passageirosIds'] != null
                ? List<String>.from(data['passageirosIds'])
                : [],
          );
        } else {
          throw ('Dados da carona são nulos');
        }
      } else {
        throw ('Carona não encontrada');
      }
    } catch (e) {
      print('Erro ao recuperar carona por id: $e');
      return null;
    }
  }

  Future<void> adicionarPassageiroNaCarona(String idCarona, String idPassageiro) async {
    try {
      DocumentReference caronaRef = _caronasCollection.doc(idCarona);

      await caronaRef.update({
        'passageirosIds': FieldValue.arrayUnion([idPassageiro])
      });

      ChatGrupoDAO _chatGrupoDAO = ChatGrupoDAO();
      await _chatGrupoDAO.addMemberToChat(caronaRef.id, user!.id, user!.nome);
    } catch (e) {
      print('Erro ao adicionar passageiro na carona: $e');
    }
  }

  Future<void> decrementarVagas(String idCarona) async {
    try {
      DocumentReference caronaRef = _caronasCollection.doc(idCarona);

      await caronaRef.update({
        'vagas': FieldValue.increment(-1)
      });
    } catch (e) {
      print('Erro ao decrementar vagas: $e');
    }
  }

  Future<Carona?> recuperarCaronaPorIdDoc(String id) async {
    try {
      DocumentSnapshot snapshot = await _caronasCollection.doc(id).get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          return Carona(
            id: id,
            origem: List<double>.from(data['origem']),
            dest: List<double>.from(data['dest']),
            origemLocal: data['origemLocal'],
            origemDestino: data['origemDestino'],
            data: data['data'],
            hora: data['hora'],
            autoAceitar: data['autoAceitar'],
            veiculoId: data['veiculoId'],
            vagas: data['vagas'],
            motoristaId: data['motoristaId'],
            passageirosIds: data['passageirosIds'] != null
                ? List<String>.from(data['passageirosIds'])
                : [],
          );
        } else {
          throw ('Dados da carona são nulos');
        }
      } else {
        throw ('Carona não encontrada');
      }
    } catch (e) {
      print('Erro ao recuperar carona por id: $e');
      return null;
    }
  }

  Future<String?> docIdString(String id) async {
    try {
      QuerySnapshot querySnapshot = await _caronasCollection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        return snapshot.id; // Retorna o Document ID
      } else {
        throw ('Carona não encontrada');
      }
    } catch (e) {
      print('Erro ao recuperar carona por id: $e');
      return null;
    }
  }

  Future<List<Carona>> recuperarCaronasPorPapelEPeriodo(
      String userId, String papel, String periodo) async {
    try {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      Timestamp timestampHoje = Timestamp.fromDate(today);

      Query query = _caronasCollection;

      if (papel == 'Motorista') {
        query = query.where('motoristaId', isEqualTo: userId);
      } else if (papel == 'Passageiro') {
        query = query.where('passageirosIds', arrayContains: userId);
      }

      if (periodo == 'Atual') {
        query = query.where('dataTimestamp', isGreaterThanOrEqualTo: timestampHoje);
      } else if (periodo == 'Passado') {
        query = query.where('dataTimestamp', isLessThan: timestampHoje);
      }
      query = query.orderBy('dataTimestamp');

      QuerySnapshot querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return Carona(
          id: doc.id,
          origem: List<double>.from(data!['origem']),
          dest: List<double>.from(data['dest']),
          origemLocal: data['origemLocal'],
          origemDestino: data['origemDestino'],
          data: data['data'],
          hora: data['hora'],
          autoAceitar: data['autoAceitar'],
          veiculoId: data['veiculoId'],
          vagas: data['vagas'],
          motoristaId: data['motoristaId'],
          passageirosIds: data['passageirosIds'] != null
              ? List<String>.from(data['passageirosIds'])
              : [],
        );
      }).toList();
    } catch (e) {
      print('Erro ao recuperar caronas por papel e período: $e');
      return [];
    }
  }

}
