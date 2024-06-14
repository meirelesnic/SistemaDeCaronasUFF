class Avaliacao {
  String autor;
  int nota;
  String comentario;

  Avaliacao({required this.autor, required this.nota, required this.comentario});

  factory Avaliacao.fromMap(Map<String, dynamic> data) {
    return Avaliacao(
      autor: data['autor'] ?? '',
      nota: data['nota'] ?? 0,
      comentario: data['comentario'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autor': autor,
      'nota': nota,
      'comentario': comentario,
    };
  }
}