import 'package:star_builder/character.dart';
import 'package:star_builder/database_class.dart';
import 'package:star_builder/database_race.dart';
import 'package:star_builder/database_source.dart';
import 'package:star_builder/database_theme.dart';
import "package:test/test.dart";

final bobString =
"""{
	"Basic Info": {
		"Name": "Bob",
		"Race": "Human",
		"BaseClass": "Mystic",
		"Theme": "Colonist"
	}
}""";

void main() {
  group("Character", () {
    test('Save Test', () async {

      // TODO Once Flutter can load assets in tests, update this test to work
      // see: https://github.com/flutter/flutter/issues/12999
      await SourceDb.loadDatabase();
      await ThemeDb.loadDatabase();
      await RaceDb.loadDatabase();
      await ClassDb.loadDatabase();

      StarfinderCharacter character =
          new StarfinderCharacter("Bob", "Human", "", "Mystic", "Colonist");
      String characterSave = character.save();
      expect(characterSave, bobString);
    });
  });
}
