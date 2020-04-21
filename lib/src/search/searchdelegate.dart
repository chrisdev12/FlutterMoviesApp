import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:movies_app/src/providers/getMovies.dart';

class DataSearch extends SearchDelegate{

  String selected = '';

  //Hardcoded lists
  // final peliculas = [
  //   'Spiderman',
  //   'Batman',
  //   'Superman'

  // ];

  // final peliculasRecientes = [
  //   'Mujer maravilla',
  //   'Hombres de negro'
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestra appBar
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => query = ''
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar (leading tal cual)
    return IconButton(
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ),
        // Método interno de esta clase para regresarse
        onPressed: () => close(context, null)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultos que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selected),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Crea el conocido apartado de sugerencias cuando el usuario escribe

    /**
      Crear la lista filtro de nuestro "Typehead". StarWith
     * es un método que ya implementa un regex
     En este caso no podemos usar un Widget en el return del if(snapshot.haddata)
     por el tipo de map que estámos usando, pues el tipo de lista no sería igual al que se espera
    */
   

    if(query.isEmpty){
      return Container();
    }

    final movies = new GetMovies();

    return FutureBuilder(
      future: movies.getByName(query: query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData){
          return ListView(
            children: snapshot.data.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/gifs/loading.gif'),
                  fadeInDuration: Duration(milliseconds: 150),
                  fit: BoxFit.cover,
                  width: 50.0,
                ),  
                title: Text(
                  movie.title
                ),
                subtitle: Text(
                  movie.originalTitle
                ),
                onTap: (){
                  query = movie.title;
                  close(context, null);
                  Navigator.pushNamed(context, 'details', arguments: movie);
                }
              );
            }).toList()
          );
        } else{
          return Center(child:
            CircularProgressIndicator()
          );
        }
      },
    );
  }




  // Ejemplo con listas hardcoded

    // final suggestedList = (query.isEmpty) 
    //       ? peliculasRecientes 
    //       : peliculas.where(
    //         (i) => i.toLowerCase().startsWith(query.toLowerCase())
    //       ).toList();

    // return ListView.builder(
    //   itemCount: suggestedList.length,
    //   itemBuilder: (context, i){
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(
    //         suggestedList[i]
    //       ),
    //       onTap: (){
    //         query = suggestedList[i];
    //         selected = suggestedList[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
}