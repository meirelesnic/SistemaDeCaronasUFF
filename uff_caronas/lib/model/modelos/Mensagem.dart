import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Mensagem {
  String _texto;
  String _userId;
  String _userName;
  DateTime? _hora;

  Mensagem({
    required String texto,
    required String userId,
    required String userName,
    DateTime? hora,
  })  : _texto = texto,
        _userId = userId,
        _userName = userName,
        _hora = hora;

  // Getters e Setters
  DateTime? get hora => _hora;

  set hora(DateTime? value) {
    _hora = value;
  }

  String get texto => _texto;

  set texto(String value) {
    _texto = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  // Método para converter a classe em um mapa (para armazenar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'hora': _hora,
      'texto': _texto,
      'userId': _userId,
      'userName': _userName,
    };
  }

  factory Mensagem.fromMap(Map<String, dynamic> map) {
    return Mensagem(
      hora: map['hora'] != null ? (map['hora'] as Timestamp).toDate() : null,
      texto: map['text'],
      userId: map['userId'],
      userName: map['userName'],
    );
  }

  String? get formattedTime {
    return _hora != null ? DateFormat("HH:mm").format(_hora!) : null;
  }

  String? get formattedDate {
    return _hora != null ? DateFormat("dd/MM").format(_hora!) : null;
  }

}
