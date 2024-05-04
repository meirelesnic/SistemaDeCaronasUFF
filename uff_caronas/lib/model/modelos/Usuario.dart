class Usuario {
   int _id;
   String _nome;
   String _email;

  Usuario({
    required id,
    required String nome,
    required String email,
  })  : _nome = nome,
        _email = email,
        _id = id;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}