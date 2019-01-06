import 'package:csv/csv.dart';
import 'package:star_builder/database_attribute.dart';
import 'package:star_builder/database_source.dart';
import 'package:flutter/services.dart' show rootBundle;

class ThemeDb {
  static List<SfTheme> themes = <SfTheme>[];

  static loadDatabase() async {
    // Read the data from files
    final csvCodec = new CsvCodec();
    String csvData = await rootBundle.loadString('assets/data/themes.csv');
    List<List<dynamic>> rows = csvCodec.decoder.convert(csvData);

    // Populate the theme list
    for(List<dynamic> row in rows) {
//      debugger(message: row.toString());
//      debugger(message: row[0].toString());
      String name = row[0];
      List<SfAttribute> attributes = AttributeDb.parseCell(row[1]);
      List<String> skills = <String>[];
      List<SfSource> sources = SourceDb.parseCell(row[3]);
      themes.add(SfTheme(name,attributes,skills,sources));
    }
}
}

class SfTheme {
  final String name;
  final List<SfAttribute> attributes;
  final List<String> skills;
  final List<SfSource> sources;

  SfTheme(this.name, this.attributes, this.skills, this.sources);
}