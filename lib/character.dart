import 'dart:core';

import 'package:star_builder/database_theme.dart';

class StarfinderCharacter {
  static StarfinderCharacter activeCharacter;
  static List<StarfinderCharacter> characters;

  String name;
  String ruleset;
  String allowedSources; // "All books", "All Hardcovers", "Custom Set"
  List<String> customSources;
  String race;
  String levels;
  SfTheme theme;

  StarfinderCharacter(String name, String race, String levels, String theme) {
    this.name = name;
    this.race = race;
    this.levels = levels;
    this.theme = ThemeDb.getTheme(theme);
  }

  getThemeName() {
    return theme != null ? theme.name : "X";
  }
}
