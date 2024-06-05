class Carona {
  String id;
  List<double> origem;
  List<double> dest;
  String origemLocal;
  String origemDestino;
  String data;
  String hora;
  bool autoAceitar;
  String veiculoId;
  int vagas;
  String motoristaId;
  List<String>? passageirosIds;

  Carona({
    required this.id,
    required this.origem,
    required this.dest,
    required this.origemLocal,
    required this.origemDestino,
    required this.data,
    required this.hora,
    required this.autoAceitar,
    required this.veiculoId,
    required this.vagas,
    required this.motoristaId,
    this.passageirosIds,
  });

  String get getId => id;
  List<double> get getOrigem => origem;
  List<double> get getDest => dest;
  String get getOrigemLocal => origemLocal;
  String get getOrigemDestino => origemDestino;
  String get getData => data;
  String get getHora => hora;
  bool get getAutoAceitar => autoAceitar;
  String get getVeiculoId => veiculoId;
  int get getVagas => vagas;
  String get getMotoristaId => motoristaId;
  List<String>? get getPassageirosIds => passageirosIds;

  set setId(String id) => this.id = id;
  set setOrigem(List<double> origem) => this.origem = origem;
  set setDest(List<double> dest) => this.dest = dest;
  set setOrigemLocal(String origemLocal) => this.origemLocal = origemLocal;
  set setOrigemDestino(String origemDestino) => this.origemDestino = origemDestino;
  set setData(String data) => this.data = data;
  set setHora(String hora) => this.hora = hora;
  set setAutoAceitar(bool autoAceitar) => this.autoAceitar = autoAceitar;
  set setVeiculoId(String veiculoId) => this.veiculoId = veiculoId;
  set setVagas(int vagas) => this.vagas = vagas;
  set setMotoristaId(String motoristaId) => this.motoristaId = motoristaId;
  set setPassageirosIds(List<String> passageirosIds) =>
      this.passageirosIds = passageirosIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Carona && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
