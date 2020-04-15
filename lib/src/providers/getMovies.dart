import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/movie.dart';

class GetMovies {
  
  String _apiKey = '8a0c6d0370dbba80b58bcf21b1eb735d';
  String _url = 'api.themoviedb.org';
  
  Future <List<Movie>> nowPlaying() async{ //Petición asíncrona
    
    final url = Uri.https(_url,'3/movie/now_playing/',{
      'api_key' : _apiKey
    });
    
    final res = await http.get(url);
    final resDecoded = json.decode(res.body);
    final movies = new Movies.fromJson(jsonList: resDecoded['results']);
    
    return movies.items;
  }
}