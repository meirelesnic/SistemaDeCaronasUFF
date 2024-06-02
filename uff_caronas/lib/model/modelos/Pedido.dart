class Pedido {
  String _data;
  String _nomeOrigem;
  String _nomeDestino;
  String _status;
  String _usuario;
  String _id;
  List<double> _coordenadasOrigem;
  List<double> _coordenadasDestino;

  Pedido({
    required String data,
    required String nomeOrigem,
    required String nomeDestino,
    required String status,
    required List<double> coordenadasOrigem,
    required List<double> coordenadasDestino,
    required String id,
    required usuario,
  })  : _data = data,
        _nomeOrigem = nomeOrigem,
        _nomeDestino = nomeDestino,
        _status = status,
        _usuario = usuario,
        _id = id,
        _coordenadasOrigem = coordenadasOrigem,
        _coordenadasDestino = coordenadasDestino;

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  String get nomeOrigem => _nomeOrigem;

  set nomeOrigem(String value) {
    _nomeOrigem = value;
  }

  String get nomeDestino => _nomeDestino;

  set nomeDestino(String value) {
    _nomeDestino = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  List<double> get coordenadasOrigem => _coordenadasOrigem;

  set coordenadasOrigem(List<double> value) {
    _coordenadasOrigem = value;
  }

  List<double> get coordenadasDestino => _coordenadasDestino;

  set coordenadasDestino(List<double> value) {
    _coordenadasDestino = value;
  }

  String get id => _id;
  set id(String value) {
    _id = value;
  }

  String get usuario => _usuario;
  set usuario(String value) {
    _usuario = value;
  }
}
