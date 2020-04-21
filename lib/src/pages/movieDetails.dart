import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actor.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:movies_app/src/providers/getMovies.dart';

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
              SizedBox(height: 40.0),
              _posterTitulo(movie),
              _movieCasting(movie.id)
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
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 195.0,
              ),
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

  Widget _movieCasting(int id) {

    final movieProvider = new GetMovies();
    return FutureBuilder(
      future: movieProvider.getCast(movieId: id.toString()),
      // initialData: InitialData, Evitamos el intial data, pues queremos hacer una animación tipo loading
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {    
        //Esto es análogo al resolve de las promesas en JS: Si tiene data
        //Dibuja el widget que deseo, de lo contrario dibujame un loading.      
        if(snapshot.hasData){
          return _casting(
            movieCast: snapshot.data,
            context: context
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

  Widget _casting({List<Actor> movieCast, BuildContext context}) {

    return SizedBox(
      height: 300.0,
      child: PageView.builder(
        controller: new PageController(
          initialPage: 1,
          viewportFraction: 0.4 
        ) ,
        pageSnapping: false,
        itemCount: movieCast.length,
        itemBuilder: (context, i) => _actorCard(movieCast[i])
      ),
    );
  }

  _actorCard(actor) {

    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPosterImg()),
              placeholder: AssetImage('assets/gifs/actor-loading.gif'),
              fit: BoxFit.cover,
              //Para manejar una simetría entre el image y el placeholder
              height: 180.0,
            ),
          ),
          Text(
            actor.character,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17.0
            )
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.indigo
            ),
          )
        ]
      )
    );
  }
}