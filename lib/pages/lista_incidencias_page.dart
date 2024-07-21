import 'package:flutter/material.dart';
import '../models/incidencia.dart';
import '../utils/database_helper.dart';
import 'detalle_incidencia_page.dart';

class ListaIncidenciasPage extends StatelessWidget {
  const ListaIncidenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidencias Registradas'),
      ),
      body: FutureBuilder<List<Incidencia>>(
        future: DatabaseHelper().incidencias(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final incidencia = snapshot.data![index];
              return ListTile(
                title: Text(incidencia.titulo),
                subtitle: Text(incidencia.fecha.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleIncidenciaPage(incidencia: incidencia),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
