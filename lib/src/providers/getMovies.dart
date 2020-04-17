import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/movie.dart';
import 'package:flutter/material.dart';

class GetMovies {
  
  String _apiKey = '8a0c6d0370dbba80b58bcf21b1eb735d';
  String _url = 'api.themoviedb.org';
  String path;
  int _popularesPage = 0;
  
  Future <List<Movie>> _processRes(Uri url) async{
    
    final res = await http.get(url);
    final resDecoded = json.decode(res.body);
    final movies = new Movies.fromJson(jsonList: resDecoded['results']);
    return movies.items;
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
  
    _popularesPage ++;
    final url = Uri.https(_url,path,{
      'api_key' : _apiKey,
      'page': _popularesPage.toString()
    });
    
    final res =  await _processRes(url);
    _topRanked.addAll(res);
    rankedSink(_topRanked); //Vital para el StreamBuilder
    return res;
  }
}