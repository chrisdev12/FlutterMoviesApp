import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/getMovies.dart';
import 'package:movies_app/src/widgets/card_swiper.dart';
import 'package:movies_app/src/widgets/horizontal.dart';

class HomePage extends StatelessWidget {
  
  final newMovies = new GetMovies();
  
  @override
  Widget build(BuildContext context) {
    
    newMovies.getRanked(path: '3/movie/top_rated/');
    
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
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _cardSwiper(),
              _footer(context)
            ],
          ),
        )
      ),
    );
  }

  Widget _cardSwiper() {
    
    return FutureBuilder(
      future: newMovies.getNowPlaying(path: '3/movie/now_playing/'),
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

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead, //Configurar el tema global
            ),
          ),
          StreamBuilder(
            stream: newMovies.rankedStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  movies: snapshot.data,
                  
                  //Función debe entrarse dentro de otra anonima pues lleva parametros obligatorios.
                  siguientePagina: () => newMovies.getRanked(path: '3/movie/top_rated/')
                  
                );
              } else{
                return Center(child:
                  CircularProgressIndicator()
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

/**
 * [FutureBuilder] Si impririmos el newMovies.NowPlaying
 * nos trae una instancia de future, pues el materialApp se ejecuta
 * más rápido que la operación asincrona. 
 */