import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';

class DetailsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    /**
    * [ModalRoute] nos permite recibir los argumentos sin necesidad de hacerlo
    * mediante el constructor de la clase(como típicamente se haria 
    * cuando usamos el pushNamed en nuestra anterior pantalla)
    */
    final Movie movie = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(movie),
          //ListView de los slivers
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20.0),
              _posterTitulo(movie),
            ])
          )
        ],
      )
    );
  }

  _appBar(Movie movie) {
    
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 220.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 16.0),
          //Análogo al hidden del css
          overflow: TextOverflow.ellipsis
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/gifs/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Movie movie) {
    
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 185.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 22.0),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height:10.0),
                Text(movie.overview),
                SizedBox(height:10.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    SizedBox(width: 5.0),
                    Text(movie.voteAverage.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}