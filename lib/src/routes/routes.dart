import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/home.dart';
import 'package:movies_app/src/pages/movieDetails.dart';

Map <String, WidgetBuilder> setRoutes(){
  
  return <String, WidgetBuilder>{
    
    '/' : (context) => HomePage(),
    'details': (context) => DetailsPage(),
  };
}