/// Primary characters viewer core interface.
library;
export 'src/ui/screens/characters_list_screen.dart' show CharactersListScreen;

enum CharactersListVariant {
  theSimpsons,
  theWire,
  starTrek
}

final charactersListVariant = CharactersListVariant.theSimpsons;
bool charactersListUseMockData = true;