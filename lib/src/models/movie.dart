//Used pasteJsonAsCode

//Está clase servira de contenedor para guardar todas las peliculas en un lista.
// Crearemos una listade objeto, en cada indíce se pdoran acceder las porpiedades de ese objeto
class Movies{ 
    
  List<Movie> moviesList = new List();
  
  Movies();
  
  Movies.fromJson({List<dynamic> jsonList}){
    
    if (jsonList == null) return;
    
    for (var item in jsonList){
  
      final newMovie = new Movie.fromJsonMap(item);
      moviesList.add(newMovie);
    }
  }
  
  //Requerido, sin el getter no podemos usar el .items  desde nuestro provider
  List get items => moviesList; 
}


class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({ //Constructor normal para definir variables de la clase
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });
  
  //Constructor con nombre para usar el modelo / generar una instancía de pelicula según el Json obtenido
  
  Movie.fromJsonMap(Map<String, dynamic> json){
    
    popularity = json['popularity'] / 1; //Evitar que no sea double
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
    
  }
  
  getPosterImg(){
    
    if(posterPath == null){
      return 'https://optinmonster.com/wp-content/uploads/2018/06/11-brilliant-404-pages-to-turn-lost-visitors-into-loyal-customers-2.png'; 
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  } 
}
