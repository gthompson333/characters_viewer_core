import 'package:flutter/material.dart';
import '../../business/view_models/characters_list_view_model.dart';

class CharacterDetail extends StatelessWidget {
  CharacterDetail({super.key, required this.character});

  final CharacterViewModel? character;

  @override
  Widget build(BuildContext context) {
    final characterImageProvider = character?.imageURL != null
        ? NetworkImage((character?.imageURL)!)
        : AssetImage('images/character_placeholder.png',
            package: 'characters_viewer_core');

    return Scaffold(
      appBar: AppBar(
        title: Text(character?.name ?? 'No Character selected'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeInImage(
                image: characterImageProvider as ImageProvider,
                placeholder: AssetImage('images/character_placeholder.png',
                    package: 'characters_viewer_core'),
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              character?.description ?? 'No character description available.',
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
