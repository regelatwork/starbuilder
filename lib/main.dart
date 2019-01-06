import 'package:flutter/material.dart';
import 'package:star_builder/character_editor.dart';
import 'package:star_builder/database_source.dart';
import 'package:star_builder/database_theme.dart';
import 'package:star_builder/home.dart';

void main() {
  SourceDb.loadDatabase();
  ThemeDb.loadDatabase();
  runApp(StarBuilderApp());
}

class StarBuilderApp extends StatelessWidget {
//  @override
//  void initState() {
//    final json = JSON.decode(
//        DefaultAssetBundle.of(context).loadString("assets/data.json")
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      title: 'Starbuilder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        Home.ROUTE: (context) => Home(),
        CharacterEditor.ROUTE: (context) => CharacterEditor(),
      },
    );
  }
}
