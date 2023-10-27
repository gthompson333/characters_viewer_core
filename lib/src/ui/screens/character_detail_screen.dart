import 'package:flutter/material.dart';
import '../../business/view_models/characters_list_view_model.dart';

class CharacterDetail extends StatelessWidget {
  final CharacterViewModel character;

  CharacterDetail({required this.character});

  @override
  Widget build(BuildContext context) {
    print('Image URL: ${character.imageURL}');
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.network(character.imageURL),
            ),
            const SizedBox(height: 16),
            Text(character.description)
          ],
        ),
      ),
    );
  }
}