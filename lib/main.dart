import 'package:flutter/material.dart';
import 'package:movies_app/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie app',
      initialRoute: '/',
      routes: setRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

