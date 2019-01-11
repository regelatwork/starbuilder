import 'dart:core';

import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_theme.dart';

class StarfinderCharacter {
  static StarfinderCharacter activeCharacter;
  static List<StarfinderCharacter> characters;

  String name;
  String ruleset;
  String allowedSources; // "All books", "All Hardcovers", "Custom Set"
  List<String> customSources;
  SfRace race;
  String levels;
  SfTheme theme;

  StarfinderCharacter(String name, String race, String levels, String theme) {
    this.name = name;
    this.race = RaceDb.getRace(race);
    this.levels = levels;
    this.theme = ThemeDb.getTheme(theme);
  }

  getThemeName() {
    return theme != null ? theme.name : "";
  }

  String getRaceName() {
    return race != null ? race.name : "";
  }
}
