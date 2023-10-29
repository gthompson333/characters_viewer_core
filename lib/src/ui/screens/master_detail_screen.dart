import 'package:flutter/material.dart';
import '../../business/view_models/characters_list_view_model.dart';
import 'characters_list_screen.dart';
import 'character_detail_screen.dart';

class MasterDetailContainer extends StatefulWidget {
  @override
  MasterDetailContainerState createState() => MasterDetailContainerState();
}

class MasterDetailContainerState extends State<MasterDetailContainer> {
  // Track the currently selected character here. Only used for tablet layouts.
  CharacterViewModel? _selectedCharacter;

  Widget _phoneLayout() {
    return CharactersListScreen(
      characterSelectedCallback: (character) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetail(
              character: character,
            ),
          ),
        );
      },
    );
  }

  Widget _tabletLayout() {
    // For tablets, return a layout that has characters listed on the left
    // and details on the right.
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: CharactersListScreen(
            characterSelectedCallback: (character) {
              setState(() {
                _selectedCharacter = character;
              });
            },
            characterSelected: _selectedCharacter,
          ),
        ),
        Flexible(
          flex: 3,
          child: CharacterDetail(
            character: _selectedCharacter,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide < 600) {
      return _phoneLayout();
    }
    return _tabletLayout();
  }
}
