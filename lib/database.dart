import 'package:flutter/services.dart';
import 'package:star_builder/database_class.dart';
import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_source.dart';
import 'package:star_builder/database_theme.dart';

class MainDb {
  static loadDatabaseWithRootBundle() async {
    await loadDatabaseWithAssetBundle(rootBundle);
  }

  static loadDatabaseWithAssetBundle(AssetBundle assetBundle) async {
    await SourceDb.loadDatabase(assetBundle);
    await ThemeDb.loadDatabase(assetBundle);
    await RaceDb.loadDatabase(assetBundle);
    await ClassDb.loadDatabase(assetBundle);
  }

  static List<String> getAssetNames() {
    return <String>[
      SourceDb.assetName,
      ThemeDb.assetName,
      RaceDb.assetName,
      ClassDb.assetName
    ];
  }
}
