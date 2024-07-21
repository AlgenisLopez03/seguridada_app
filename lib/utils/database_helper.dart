import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/incidencia.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'incidencias.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE incidencias(id INTEGER PRIMARY KEY, titulo TEXT, fecha TEXT, descripcion TEXT, fotoPath TEXT, audioPath TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertIncidencia(Incidencia incidencia) async {
    final db = await database;
    await db.insert(
      'incidencias',
      incidencia.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Incidencia>> incidencias() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('incidencias');
    return List.generate(maps.length, (i) {
      return Incidencia(
        titulo: maps[i]['titulo'],
        fecha: DateTime.parse(maps[i]['fecha']),
        descripcion: maps[i]['descripcion'],
        fotoPath: maps[i]['fotoPath'],
        audioPath: maps[i]['audioPath'],
      );
    });
  }
}
