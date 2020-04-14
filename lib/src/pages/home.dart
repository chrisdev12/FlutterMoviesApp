import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       * //Ideal para dispositivos con Notch. El SafeArea nos permite desplegar nuestro contenido en
       * lugares donde se sabe que se pueden desplegar las cosas/información
       */
      body: SafeArea( 
        child: Text('First commit'),
      ),
    );
  }
}