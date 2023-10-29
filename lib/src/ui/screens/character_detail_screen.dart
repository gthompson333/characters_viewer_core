import 'package:flutter/material.dart';
import '../../business/view_models/characters_list_view_model.dart';

class CharacterDetail extends StatelessWidget {
  CharacterDetail(
      {super.key, required this.character});

  final CharacterViewModel? character;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.network(character?.imageURL ?? ''),
        ),
        const SizedBox(height: 16),
        Text(character?.description ?? '')
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(character?.name ?? 'No Character selected'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
