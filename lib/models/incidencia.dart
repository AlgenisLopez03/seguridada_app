class Incidencia {
  String titulo;
  DateTime fecha;
  String descripcion;
  String fotoPath;
  String audioPath;

  Incidencia({
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    required this.fotoPath,
    required this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'fecha': fecha.toIso8601String(),
      'descripcion': descripcion,
      'fotoPath': fotoPath,
      'audioPath': audioPath,
    };
  }
}
