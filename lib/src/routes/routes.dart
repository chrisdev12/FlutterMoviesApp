import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/home.dart';

Map <String, WidgetBuilder> setRoutes(){
  
  return <String, WidgetBuilder>{
    
    '/' : (context) => HomePage(),
  
  };
  
}