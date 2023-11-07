import 'package:flutter/foundation.dart';
import '../../data/duck_duck_go/duck_duck_go_api.dart';
import '../../data/duck_duck_go/duck_duck_go_base.dart';
import '../../data/duck_duck_go/duck_duck_go_mock.dart';
import '../../data/duck_duck_go/duck_duck_go_remote.dart';
import '../../data/network_utils/network_response_states.dart';

class CharactersListViewModel extends ChangeNotifier {
  // Private
  static const _charactersFetchErrorMessage = "Characters data not available";

  // Fetch either mock data or real remote data, based on global boolean.
  final DuckDuckGoAPI _duckDuckGoAPI =
  useMockData ? DuckDuckGoMockAPI() : DuckDuckGoRemoteAPI();

  // Used to keep a handle on the total collection of characters.
  // Needed for the search logic.
  final List<CharacterViewModel> _allCharacters = [];

  // Public
  String title = "";
  static bool useMockData = false;

  // Network error message. Non-null if an error is present.
  String? errorMessage;

  // The characters that will show in the UI.
  List<CharacterViewModel> charactersToDisplay = [];

  void searchCharacters({String query = ''}) async {
    print('Searching characters with query term: $query.');
    if (query.isEmpty) {
      charactersToDisplay = _allCharacters;
    } else {
      // Search character collection for characters whose title or description contains
      // the search query text.
      charactersToDisplay = _allCharacters
          .where((character) =>
      character.name.contains(query) ||
          character.description.contains(query))
          .toList();
    }
    print('${charactersToDisplay.length} characters found.');

    // Notify UI that a new character collection is available.
    notifyListeners();
  }

  void fetchCharacters() async {
    print('Fetching characters.');
    errorMessage = null;
    final fetchedCharacters = await _duckDuckGoAPI.fetchCharacters();

    if (fetchedCharacters is SuccessState) {
      title = fetchedCharacters.value.heading;

      // We have characters. Clear out the old ones.
      _allCharacters.clear();

      // Map the raw data characters to character view models.
      for (final character in fetchedCharacters.value.characters) {
        final characterNameDescription = character.text.split('-');

        // Make an assumption that each character will have both a name and description.
        if (characterNameDescription.length > 1) {
          _allCharacters.add(CharacterViewModel(
              name: characterNameDescription[0],
              imageURL: character.iconURL.isNotEmpty
                  ? '${DuckDuckGoRemoteBase.imageBaseURL}${character.iconURL}'
                  : null,
              description: characterNameDescription[1]));
        }
      }
    } else if (fetchedCharacters is ErrorState) {
      errorMessage = _charactersFetchErrorMessage;
    }

    charactersToDisplay = _allCharacters;
    print('${charactersToDisplay.length} characters fetched.');

    // Notify UI that a new character collection is available.
    notifyListeners();
  }
}

class CharacterViewModel {
  late final String name;
  final String? imageURL;
  late final String description;

  CharacterViewModel({required this.name,
    this.imageURL,
    this.description = ''});
}
