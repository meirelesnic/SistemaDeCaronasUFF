class Pedido {
  String _data;
  String _nomeOrigem;
  String _nomeDestino;
  List<int> _coordenadasOrigem;
  List<int> _coordenadasDestino;

  Pedido({
    required String data,
    required String nomeOrigem,
    required String nomeDestino,
    required List<int> coordenadasOrigem,
    required List<int> coordenadasDestino, required String id, required usuario,
  })  : _data = data,
        _nomeOrigem = nomeOrigem,
        _nomeDestino = nomeDestino,
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

  List<int> get coordenadasOrigem => _coordenadasOrigem;

  set coordenadasOrigem(List<int> value) {
    _coordenadasOrigem = value;
  }
  List<int> get coordenadasDestino => _coordenadasDestino;

  set coordenadasDestino(List<int> value) {
    _coordenadasDestino = value;
  }
}
