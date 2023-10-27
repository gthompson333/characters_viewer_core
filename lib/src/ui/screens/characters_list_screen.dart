import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business/view_models/characters_list_view_model.dart';
import 'character_detail_screen.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  CharactersListScreenState createState() => CharactersListScreenState();
}

class CharactersListScreenState extends State<CharactersListScreen> {
  // Character view model objects.
  final CharactersListViewModel _charactersListViewModel =
      CharactersListViewModel();

  @override
  void initState() {
    _charactersListViewModel.fetchCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_charactersListViewModel.title),
      ),
      body: _buildListView(_charactersListViewModel),
    );
  }

  Widget _buildListView(CharactersListViewModel viewModel) {
    return ChangeNotifierProvider<CharactersListViewModel>(
      create: (context) => viewModel,
      child:
          Consumer<CharactersListViewModel>(builder: (context, model, child) {
        return ListView.builder(
            itemCount: model.characters.length,
            itemBuilder: (context, index) {
              final character = model.characters[index];
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _characterListItem(character, context),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterDetail(character: character),
                    ),
                  );
                },
              );

              /*return _characterListItem(model.characters[index], context);*/
            });
      }),
    );
  }

  Widget _characterListItem(
      CharacterViewModel character, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(character.name),
      ),
    );
  }
}
