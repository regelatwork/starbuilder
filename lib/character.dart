import 'dart:core';

class StarfinderCharacter {
  static StarfinderCharacter activeCharacter;

  String name;
  String ruleset;
  String allowedSources; // "All books", "All Hardcovers", "Custom Set"
  List<String> customSources;
  String race;
  String levels;
  String theme;

  StarfinderCharacter(String name, String race, String levels, String theme) {
    this.name = name;
    this.race = race;
    this.levels = levels;
    this.theme = theme;
  }
}

