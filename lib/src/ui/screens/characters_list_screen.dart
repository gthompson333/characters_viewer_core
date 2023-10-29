import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business/view_models/characters_list_view_model.dart';

class CharactersListScreen extends StatefulWidget {
  CharactersListScreen(
      {super.key,
      required this.characterSelectedCallback,
      this.characterSelected});

  final ValueChanged<CharacterViewModel> characterSelectedCallback;
  final CharacterViewModel? characterSelected;

  @override
  CharactersListScreenState createState() => CharactersListScreenState();
}

class CharactersListScreenState extends State<CharactersListScreen> {
  // Character view model objects.
  final CharactersListViewModel _charactersListViewModel =
      CharactersListViewModel();

  final TextEditingController _searchEditingController =
      TextEditingController();

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
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _charactersListViewModel.searchCharacters(query: value);
                  },
                  controller: _searchEditingController,
                  decoration: InputDecoration(
                      labelText: "Search characters",
                      hintText: "Search characters",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: _buildListView(_charactersListViewModel),
              ),
            ],
          ),
        ));
  }

  // The list view reactively gets rebuilt upon new data arriving.
  // using the Provider package.
  Widget _buildListView(CharactersListViewModel viewModel) {
    return ChangeNotifierProvider<CharactersListViewModel>(
      create: (context) => viewModel,
      child: Consumer<CharactersListViewModel>(
        builder: (context, model, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: model.charactersToDisplay.length,
            itemBuilder: (context, index) {
              final character = model.charactersToDisplay[index];
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: ListTile(
                      title: Text(character.name),
                      onTap: () => widget.characterSelectedCallback(character),
                      selected: widget.characterSelected == character,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
