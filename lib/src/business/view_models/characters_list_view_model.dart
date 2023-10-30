import 'package:flutter/foundation.dart';
import '../../data/duck_duck_go/duck_duck_go_api.dart';
import '../../data/duck_duck_go/duck_duck_go_base.dart';
import '../../data/duck_duck_go/duck_duck_go_mock.dart';
import '../../data/duck_duck_go/duck_duck_go_remote.dart';
import '../../data/network_utils/network_response_states.dart';

class CharactersListViewModel extends ChangeNotifier {
  static const _charactersFetchErrorMessage = "Characters data not available";
  String title = "";
  static bool useMockData = false;

  // Fetch either mock data or real remote data, based on global boolean.
  final DuckDuckGoAPI _duckDuckGoAPI =
  useMockData ? DuckDuckGoMockAPI() : DuckDuckGoRemoteAPI();

  final List<CharacterViewModel> _allCharacters = [];

  // A list of character view model objects suitable for presentation in the UI.
  List<CharacterViewModel> charactersToDisplay = [];

  /// Network error message. Non-null if an error is present.
  String? errorMessage;

  void searchCharacters({String query = ''}) async {
    if (query.isEmpty) {
      charactersToDisplay = List.from(_allCharacters);
    } else {
      // Search character collection for characters whose title or description contains
      // the search query text.
      charactersToDisplay = _allCharacters
          .where((character) =>
      character.name.contains(query) ||
          character.description.contains(query))
          .toList();
    }

    // Notify UI that a new character collection is available.
    notifyListeners();
  }

  void fetchCharacters() async {
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

    charactersToDisplay = List.from(_allCharacters);

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
