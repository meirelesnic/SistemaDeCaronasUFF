class Usuario {
   String _id;
   String _nome;
   String _email;
   String _fotoUrl;

  Usuario({
    required String id,
    required String nome,
    required String email,
    required String fotoUrl,
  })  : _nome = nome,
        _email = email,
        _id = id,
        _fotoUrl = fotoUrl;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

   String get id => _id;

  set id(String value) {
    _id = value;
  }

   String get fotoUrl => _fotoUrl;

  set fotoUrl(String value) {
    _fotoUrl = value;
  }
}