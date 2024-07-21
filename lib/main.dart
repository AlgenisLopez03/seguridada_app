import 'package:flutter/material.dart';
import 'package:seguridada_app/pages/lista_incidencias_page.dart';
import 'pages/registro_incidencia_page.dart';
import 'pages/acerca_de_page.dart';

void main() {
  runApp(SeguridadApp());
}

class SeguridadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seguridad App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/registro_incidencia': (context) => RegistroIncidenciaPage(),
        '/listado_incidencias': (context) => ListaIncidenciasPage(),
        '/acerca_de': (context) => Contratame(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seguridad App'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/pl.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registro_incidencia');
                  },
                  child: Text(
                    'Registrar Incidencia',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/listado_incidencias');
                  },
                  child: Text(
                    'Ver Incidencias Registradas',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/acerca_de');
                  },
                  child: Text(
                    'Acerca de',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
