import 'dart:async';

import 'package:flutter/material.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/character_editor.dart';
import 'package:star_builder/database_source.dart';
import 'package:star_builder/database_theme.dart';
import 'package:star_builder/home.dart';

Future main() async {
  await SourceDb.loadDatabase();
  await ThemeDb.loadDatabase();
  StarfinderCharacter.characters = [
    StarfinderCharacter("Nugget", "Ysoki", "Mechanic:8", "Xenoarchaeologist"),
    StarfinderCharacter("Koggar", "Nuar", "Soldier:1", "Ace Pilot"),
    StarfinderCharacter("Vylit", "Shirren", "Mystic:4", "Ace Pilot"),
  ];
  runApp(StarBuilderApp());
}

class StarBuilderApp extends StatelessWidget {
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
