import 'package:flutter/widgets.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/database_ability.dart';

class CharacterEditorAbilityScore extends StatefulWidget {
  final SfAbility abilityScore;

  const CharacterEditorAbilityScore({this.abilityScore});

  @override
  _CharacterEditorAbilityScoreState createState() =>
      _CharacterEditorAbilityScoreState();
}

class _CharacterEditorAbilityScoreState
    extends State<CharacterEditorAbilityScore> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(widget.abilityScore.longName),
        Text("Min: 8, "),
        Text("Current: " +
            StarfinderCharacter
                .activeCharacter.baseAbilityScores[widget.abilityScore.index]
                .toString() +
            ", "),
        Text("Max: 18"),
      ],
    );
  }
}
