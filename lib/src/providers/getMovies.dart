import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/actor.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:flutter/material.dart';

class GetMovies {
  
  String _apiKey = '8a0c6d0370dbba80b58bcf21b1eb735d';
  String _url = 'api.themoviedb.org';
  String path;
  int _popularesPage = 0;
  //Provocaremos pequeñas pausas para cargar las imagenes de manera progresiva
  bool _loading = false; 
  
  Future <List<Movie>> _processRes(Uri url) async{
    
    final res = await http.get(url);
    final resDecoded = json.decode(res.body);
    final movies = new Movies.fromJson(jsonList: resDecoded['results']);
    return movies.items;
  }

   Future <List<Actor>> _processActorRes(Uri url) async{
    
    final res = await http.get(url);
    final resDecoded = json.decode(res.body);
    final cast = new Cast.fromJsonMap(resDecoded['cast']);
    return cast.items;
  }
  
  List<Movie> _topRanked = new List();
  //Stream
  final _topRankedStream = StreamController<List<Movie>>.broadcast();
  
  Function(List<Movie>) get rankedSink => _topRankedStream.sink.add;
  Stream<List<Movie>> get rankedStream => _topRankedStream.stream;
    
  void disposeStreams(){
    _topRankedStream.close();
  }
  
  GetMovies(); 
  
   //Path: La ruta/endpoint es requerida de la Api para usar en el método nowPlaying
   
  Future <List<Movie>> getNowPlaying({@required path }) async{ 
  
    final url = Uri.https(_url,path,{
      'api_key' : _apiKey
    });
    
    return await _processRes(url);
  }
  
  Future <List<Movie>> getRanked({@required path }) async{ 
    
    /**
    * [_Loading] si está cargando: No devolver nada;
    * si no está cargando entonces seguir la función para hacer una nueva
    * petición.
    */
    if(_loading) return [];
    
    _loading = true;
    _popularesPage ++;
    
    final url = Uri.https(_url,path,{
      'api_key' : _apiKey,
      'page': _popularesPage.toString()
    });
    
    final res =  await _processRes(url);
    _topRanked.addAll(res);
    rankedSink(_topRanked); //Vital para el StreamBuilder
    
    _loading = false;
    return res;
  }

  Future <List<Actor>> getCast({String movieId}) async {

     final url = Uri.https(_url,'/3/movie/$movieId/credits',{
      'api_key' : _apiKey
    });
    
    return await _processActorRes(url);
  }

  Future <List<Movie>> getByName({@required String query }) async{ 
  
    final url = Uri.https(_url,'3/search/movie',{
      'api_key' : _apiKey,
      'query': query
    });

    return await _processRes(url);
  }
}