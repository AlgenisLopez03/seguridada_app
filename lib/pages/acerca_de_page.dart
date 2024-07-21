import 'package:flutter/material.dart';

class Contratame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seguridada Nacional')),
      body: Center(
        child: Column(
          children: [
           Image.asset('assets/images/ff.jpeg'), // Tu foto
            Text('Nombre: Algenis De los Santos Lopez', style: TextStyle(fontSize: 20.0)),
            Text('Apellido: De los Santos Lopez', style: TextStyle(fontSize: 17.0)),
            Text('Matricula: 2022-0144', style: TextStyle(fontSize: 16.5)),
            Text('frase: "La seguridad es lo primero"', style: TextStyle(fontSize: 16.5)),
          ],
        ),
      ),
    );
  }
}
