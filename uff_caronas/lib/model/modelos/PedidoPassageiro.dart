class PedidoPassageiro {
  String _id;
  String _userId;
  String _caronaId;
  String _motoristaId;
  String _status;

  PedidoPassageiro({
    required String id,
    required String userId,
    required String caronaId,
    required String motoristaId,
    required String status, // Status pode ser Pendente, Aceito, Recusado, Cancelado ou Expirado
  })  : _id = id,
        _userId = userId,
        _caronaId = caronaId,
        _motoristaId = motoristaId,
        _status = status;

  String get id => _id;
  
  String get userId => _userId;

  String get caronaId => _caronaId;

  String get motoristaId => _motoristaId;

  String get status => _status;
}
