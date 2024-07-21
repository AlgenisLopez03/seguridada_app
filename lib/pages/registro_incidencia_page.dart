import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';
import '../models/incidencia.dart';
import '../utils/database_helper.dart';

class RegistroIncidenciaPage extends StatefulWidget {
  const RegistroIncidenciaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistroIncidenciaPageState createState() => _RegistroIncidenciaPageState();
}

class _RegistroIncidenciaPageState extends State<RegistroIncidenciaPage> {
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  File? _imageFile;
  String? _audioPath;

  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _audioRecorder.openRecorder();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    _audioPath = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _audioRecorder.startRecorder(toFile: _audioPath);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  void _saveIncidencia() {
    final newIncidencia = Incidencia(
      titulo: _tituloController.text,
      fecha: _selectedDate,
      descripcion: _descripcionController.text,
      fotoPath: _imageFile?.path ?? '',
      audioPath: _audioPath ?? '',
    );

    DatabaseHelper().insertIncidencia(newIncidencia);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            ListTile(
              title: Text('Fecha: ${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Tomar Foto'),
            ),
            _imageFile == null ? Container() : Image.file(_imageFile!),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Detener Grabación' : 'Grabar Audio'),
            ),
            ElevatedButton(
              onPressed: _saveIncidencia,
              child: const Text('Guardar Incidencia'),
            ),
          ],
        ),
      ),
    );
  }
}
