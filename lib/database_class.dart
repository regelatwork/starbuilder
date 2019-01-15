import 'dart:core';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:star_builder/database_ability.dart';
import 'package:star_builder/database_source.dart';

class ClassDb {
  static List<SfClass> classes = <SfClass>[];
  static Map<String, SfClass> map = new Map();
  static String assetName = 'assets/data/classes.csv';

  static loadDatabase(AssetBundle assetBundle) async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await assetBundle.loadString(assetName);
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);
    rows.removeAt(0);

    // Populate the class list
    for (List<dynamic> row in rows) {
      String name = row[0];
      List<SfSource> sources = SourceDb.parseCell(row[1]);
      List<SfAbility> attributes = AttributeDb.parseCell(row[3]);
      SfClass c = SfClass(name, sources, attributes);
      classes.add(c);
      map.putIfAbsent(name, () => c);
    }
  }

  static SfClass getClass(String name) {
    return map[name];
  }
}

class SfClass {
  final String name;
  final List<SfSource> sources;
  final List<SfAbility> attributes;

  SfClass(this.name, this.sources, this.attributes);
}
