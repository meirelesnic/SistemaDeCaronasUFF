class Veiculo {
  String _id;
  String _modelo;
  String _marca;
  String _cor;
  int _ano;
  String _usuarioId;
  String _placa;

  Veiculo({
    required String id,
    required String modelo,
    required String marca,
    required String cor,
    required int ano,
    required String usuarioId,
    required String placa,
  })  : _id = id,
        _modelo = modelo,
        _marca = marca,
        _cor = cor,
        _ano = ano,
        _usuarioId = usuarioId,
        _placa = placa;

  String get usuarioId => _usuarioId;

  set usuarioId(String value) {
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

  String get placa => _placa;

  set placa(String value) {
    _placa = value;
  }
}
