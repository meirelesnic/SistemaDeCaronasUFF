class Veiculo {
  String _id;
  String _modelo;
  String _marca;
  String _cor;
  int _ano;
  int _usuarioId;

  Veiculo({
    required String id,
    required String modelo,
    required String marca,
    required String cor,
    required int ano,
    required usuarioId,
  })  : _id = id,
        _modelo = modelo,
        _marca = marca,
        _cor = cor,
        _ano = ano,
        _usuarioId = usuarioId;

  int get usuarioId => _usuarioId;

  set usuarioId(int value) {
    _usuarioId = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }

  String get marca => _marca;

  set marca(String value) {
    _marca = value;
  }

  String get modelo => _modelo;

  set modelo(String value) {
    _modelo = value;
  }

  String get cor => _cor;

  set cor(String value) {
    _cor = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
