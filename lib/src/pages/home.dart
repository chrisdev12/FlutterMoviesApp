import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/getMovies.dart';
import 'package:movies_app/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  
  final newMovies = new GetMovies();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartelera'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search) ,
            onPressed: (){},
          )
        ],
      ),
      /**
       * //Ideal para dispositivos con Notch. El SafeArea nos permite desplegar nuestro contenido en
       * lugares donde se sabe que se pueden desplegar las cosas/información
       */
      body: SafeArea( 
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _cardSwiper()
          ],
        )
      ),
    );
  }

  Widget _cardSwiper() {
    
    return FutureBuilder(
      future: newMovies.nowPlaying(),
      // initialData: InitialData, Evitamos el intial data, pues queremos hacer una animación tipo loading
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {    
        //Esto es análogo al resolve de las promesas en JS: Si tiene data
        //Dibuja el widget que deseo, de lo contrario dibujame un loading.      
        if(snapshot.hasData){
          return CardSwiper(
            movies: snapshot.data
          );
        } else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }
}

/**
 * @FutureBuilder: Si impririmos el newMovies.NowPlaying
 * nos trae una instancia de future, pues el materialApp se ejecuta
 * más rápido que la operación asincrona. 
 */