import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List <Movie> movies;
  final Function siguientePagina;
  
  MovieHorizontal({@required this.movies, @required this.siguientePagina});
  
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    
    /**
     * [pageController] es una clase a la cúal le puedo añadir
     *  un listener, el cúal usaremos junto con las propieades de postion
     * pixels: para saber cuando el scroll se acerca  a su máximo final, 
     * y cuando esto se cumpla disparar el listener para enviar un nuevo
     * sink al stream
     */
    
    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3 
    );
    
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -150){
        siguientePagina(); //Callback
      }
    });
    
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false, //Efecto de magneto en la transición
        //Controlador del scroll y cantidad de tarjetas en pantallas
        controller: _pageController,
        children: _topMovieCards(context),
      ),
    );
  }

  List <Widget> _topMovieCards(BuildContext context) {
    
    return movies.map((movie){
      
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/gifs/loading.gif'),
                fit: BoxFit.cover,
                //Para manejar una simetría entre el image y el placeholder
                height: 160.0,
              ),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ]
        )
      );
      
    }).toList();
  }
}