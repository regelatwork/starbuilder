import 'dart:core';

import 'package:star_builder/database_class.dart';
import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_theme.dart';
import 'dart:convert';

class StarfinderCharacter {
  static StarfinderCharacter activeCharacter;
  static List<StarfinderCharacter> characters;

  String name;
  SfRace race;
  SfClass baseClass;
  SfTheme theme;

  String ruleset;
  String allowedSources; // "All books", "All Hardcovers", "Custom Set"
  List<String> customSources;

  StarfinderCharacter(String name, String raceName, String raceSubname,
      String baseClass, String theme) {
    this.name = name;
    this.race = RaceDb.getRace(raceName, raceSubname);
    this.baseClass = ClassDb.getClass(baseClass);
    this.theme = ThemeDb.getTheme(theme);
  }

  getThemeName() {
    return theme != null ? theme.name : "";
  }

  // TODO remove this special casing for race subnames?
  String getRaceName() {
    if (race == null) {
      return "X";
    }
    return race.subname == "" ? race.name : race.subname + " " + race.name;
  }

  String getBaseClassName() {
    return baseClass != null ? baseClass.name : "X";
  }

  String save() {
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonObject = new Map();
    Map<String, dynamic> basicInfo = new Map();
    jsonObject.putIfAbsent("Basic Info", () => basicInfo);
    basicInfo.putIfAbsent("Name", () => this.name);
    basicInfo.putIfAbsent("Race", () => this.getRaceName());
    basicInfo.putIfAbsent("BaseClass", () => this.getBaseClassName());
    basicInfo.putIfAbsent("Theme", () => this.getThemeName());
    return jsonObject;
  }

  static StarfinderCharacter load(String input) {}
}
