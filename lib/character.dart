import 'dart:convert';
import 'dart:core';

import 'package:star_builder/database_class.dart';
import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_theme.dart';

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

  StarfinderCharacter() {}

  static StarfinderCharacter fromBasicInfo(String name, String raceName,
      String raceSubname, String baseClass, String theme) {
    StarfinderCharacter character = new StarfinderCharacter();
    character.name = name;
    character.race = RaceDb.getRace(raceName, raceSubname);
    character.baseClass = ClassDb.getClass(baseClass);
    character.theme = ThemeDb.getTheme(theme);
    return character;
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

  dynamic getRaceForJson() {
    if(this.race == null) {
      return "";
    }
    if(this.race.subname == "") {
      return this.race.name;
    }
    else {
      return <String>[this.race.name, this.race.subname];
    }
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
    basicInfo.putIfAbsent("Race", () => this.getRaceForJson());
    basicInfo.putIfAbsent("BaseClass", () => this.getBaseClassName());
    basicInfo.putIfAbsent("Theme", () => this.getThemeName());
    return jsonObject;
  }

  static StarfinderCharacter load(String input) {
    StarfinderCharacter character = new StarfinderCharacter();
    Map<String, dynamic> jsonObject = jsonDecode(input);
    Map<String, dynamic> basicInfo = jsonObject["Basic Info"];
    character.name = basicInfo["Name"];
    character.theme = ThemeDb.getTheme(basicInfo["Theme"]);
    character.baseClass = ClassDb.getClass(basicInfo["BaseClass"]);
    character.race = RaceDb.getRaceFromJson(basicInfo["Race"]);
    return character;
  }
}
