import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/database.dart';
import "package:test/test.dart";

import 'DiskAssetBundle.dart';

final bobString = """
{
  "Basic Info": {
    "Name": "Bob",
    "Race": "Human",
    "BaseClass": "Mystic",
    "Theme": "Colonist"
  }
}
""";

final dualityString = """
{
  "Basic Info": {
    "Name": "\\"Duality\\"",
    "Race": ["Lashunta", "Damaya"],
    "BaseClass": "Technomancer",
    "Theme": "Cyberborn"
  }
}
""";

void main() {
  setUp(() async {
    AssetBundle assetBundle =
    await DiskAssetBundle.loadAssets(MainDb.getAssetNames());
    await MainDb.loadDatabaseWithAssetBundle(assetBundle);
  });

  group("Character", () {
    test('Save Test - Bob', () async {
      StarfinderCharacter character = StarfinderCharacter.fromBasicInfo(
          "Bob", "Human", "", "Mystic", "Colonist");
      String characterSave = character.save();
      expect(characterSave, jsonEncode(jsonDecode(bobString)));
    });

    test('Save Test - "Duality"', () async {
      StarfinderCharacter character = StarfinderCharacter.fromBasicInfo(
          "\"Duality\"", "Lashunta", "Damaya", "Technomancer", "Cyberborn");
      String characterSave = character.save();
      expect(characterSave, jsonEncode(jsonDecode(dualityString)));
    });
  });
}
