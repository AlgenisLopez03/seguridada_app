import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../models/incidencia.dart';

class DetalleIncidenciaPage extends StatefulWidget {
  final Incidencia incidencia;

  const DetalleIncidenciaPage({super.key, required this.incidencia});

  @override
  // ignore: library_private_types_in_public_api
  _DetalleIncidenciaPageState createState() => _DetalleIncidenciaPageState();
}

class _DetalleIncidenciaPageState extends State<DetalleIncidenciaPage> {
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.openPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${widget.incidencia.titulo}', style: const TextStyle(fontSize: 20)),
            Text('Fecha: ${widget.incidencia.fecha.toString().split(' ')[0]}', style: const TextStyle(fontSize: 16)),
            Text('Descripción: ${widget.incidencia.descripcion}', style: const TextStyle(fontSize: 16)),
            widget.incidencia.fotoPath.isNotEmpty ? Image.file(File(widget.incidencia.fotoPath)) : Container(),
            ElevatedButton(
              onPressed: () async {
                await _audioPlayer.startPlayer(fromURI: widget.incidencia.audioPath);
              },
              child: const Text('Reproducir Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
