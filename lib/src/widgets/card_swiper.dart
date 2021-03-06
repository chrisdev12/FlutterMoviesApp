import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/src/models/movie.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Movie> movies;
    
  CardSwiper({@required this.movies});
    
  @override
  Widget build(BuildContext context) {
    //Trabajando con media queries: Nos devuelve el tamaño actual de la pagina, con lo cúal podemos jugar nosotros
    final _screenSize = MediaQuery.of(context).size;  
    return Container( //Swiper debe estár dentro del container
      padding: EdgeInsets.only(top:20.0),
      alignment: Alignment.center,
      child: Swiper(
        itemWidth: _screenSize.width * 0.75,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index){ //Este index es el que nos permite recorrer arreglos
          return GestureDetector(
            onTap: (){
              //Manejo de rutas y paso de argumentos a dicha página
              Navigator.pushNamed(context, 'details', arguments: movies[index]);
            },
            child: Hero(
              tag: movies[index].id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: AssetImage('assets/gifs/loading.gif'),
                  fadeOutDuration: Duration(milliseconds: 500),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        layout: SwiperLayout.STACK, // Necesita que se especifique el el itemHight e itemWidth
        // pagination: SwiperPagination(), //Permite que se visualize con pequeños iconos en la parte inferior el número de elementos
        // control: SwiperControl(), //Pone las fechas de los controladores.
      ),
    );
  }
}