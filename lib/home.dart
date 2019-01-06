import 'package:flutter/material.dart';
import 'package:star_builder/character.dart';
import 'package:star_builder/character_editor.dart';

class Home extends StatefulWidget {
  static const String ROUTE = "/";

  Home({Key key}) : super(key: key);

  final String title = 'StarBuilder 0.1';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StarfinderCharacter> characters = [
    StarfinderCharacter("Nugget", "Ysoki", "Mechanic:8", "Xenoarchaeologist"),
    StarfinderCharacter("Koggar", "Nuar", "Soldier:1", "Ace Pilot"),
    StarfinderCharacter("Vylit", "Shirren", "Mystic:4", "Ace Pilot"),
  ];

  void _newCharacter() {
    StarfinderCharacter character = new StarfinderCharacter("NEW CHAR", "Human", "Solider:1", "Colonist");
    StarfinderCharacter.activeCharacter = character;
    characters.add(character);
    Navigator.pushNamed(context, CharacterEditor.ROUTE);
  }
  void _editCharacter(StarfinderCharacter character) {
    StarfinderCharacter.activeCharacter = character;
    Navigator.pushNamed(context, CharacterEditor.ROUTE);
  }
  void _displayOptions() {
  }
  void _defaults() {
  }

  Widget buildBody(BuildContext ctxt, int index) {
    StarfinderCharacter character = characters[index];
    return ListTile(
      title: Text(character.name),
        subtitle: Text(character.theme+" "+character.race+" "+character.levels),
      enabled: index%2==0,
    onTap: (){_editCharacter(character);},
    );
  }

  ListView _buildList(context) {
    return ListView.builder(
        itemCount: characters.length,
        itemBuilder: (BuildContext ctxt, int index) =>buildBody(ctxt, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image(image: AssetImage("assets/images/starfinder-logo.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    'New Character',
                  ),
                  onPressed: _newCharacter,
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    'Display Options',
                  ),
                  onPressed: _displayOptions,
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    'Defaults',
                  ),
                  onPressed: _defaults,
                ),
              ],
            ),
            Flexible(
              child: _buildList(context),
            ),
          ],
        ),
      ),
    );
  }
}
