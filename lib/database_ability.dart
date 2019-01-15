/// Datastore for Attribute objects. This datastore doesn't use a CSV to back it
/// since no changes are expected.
class AttributeDb {
  static List<SfAbility> attributes = <SfAbility>[
    SfAbility.strength,
    SfAbility.dexterity,
    SfAbility.constitution,
    SfAbility.intelligence,
    SfAbility.wisdom,
    SfAbility.charisma
  ];

  static List<SfAbility> parseCell(String input) {
    if (input[0] == '*') {
      return attributes;
    } else if (input[0] == '[') {
      input = input.substring(1, input.length - 1);
      List<SfAbility> attributes = <SfAbility>[];
      for (String attribute in input.split(',')) {
        attributes.add(parse(attribute));
      }
      return attributes;
    } else {
      return <SfAbility>[parse(input)];
    }
  }

  static SfAbility parse(String input) {
    try {
      String shortInput = input.substring(0, 3);
      for (SfAbility attribute in attributes) {
        if (shortInput == attribute.shortName) {
          return attribute;
        }
      }
    } catch (e) {
      throw Exception("Invalid Attribute: " + input);
    }
  }
}

class SfAbility {
  static SfAbility strength = SfAbility("Str", "Strength", 0);
  static SfAbility dexterity = SfAbility("Dex", "Dexterity", 1);
  static SfAbility constitution = SfAbility("Con", "Constitution", 2);
  static SfAbility intelligence = SfAbility("Int", "Intelligence", 3);
  static SfAbility wisdom = SfAbility("Wis", "Wisdom", 4);
  static SfAbility charisma = SfAbility("Cha", "Charisma", 5);

  final String shortName;
  final String longName;
  final int index;

  SfAbility(this.shortName, this.longName, this.index);

  @override
  String toString() {
    return shortName;
  }
}
