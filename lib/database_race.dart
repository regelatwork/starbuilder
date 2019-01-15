import 'dart:core';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class RaceDb {
  static List<SfRace> races = <SfRace>[];
  static Map<String, List<SfRace>> racesByName = new Map();
  static Map<String, SfRace> racesBySubname = new Map();
  static String assetName = 'assets/data/races.csv';

  static loadDatabase(AssetBundle assetBundle) async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await assetBundle.loadString(assetName);
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);
    rows.removeAt(0);

    // Populate the race list
    for (List<dynamic> row in rows) {
      String name = row[0];
      String subname = row[2];
      SfRace race = SfRace(name, subname);
      races.add(race);
      racesByName.putIfAbsent(name, () => <SfRace>[]);
      racesByName[name].add(race);
      racesBySubname.putIfAbsent(name + subname, () => race);
    }
  }

  static List<SfRace> getRaces(String name) {
    return racesByName[name];
  }

  static SfRace getRace(String name, String subname) {
    return racesBySubname[name + subname];
  }

  static SfRace getRaceFromJson(dynamic json) {
    if(json is String) {
      return getRace(json, "");
    }
    else{
      return getRace(json[0], json[1]);
    }
  }
}

class SfRace {
  final String name;
  final String subname;

  SfRace(this.name, this.subname);
}
