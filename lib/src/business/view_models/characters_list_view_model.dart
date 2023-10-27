import 'package:flutter/foundation.dart';
import '../../../characters_viewer_core.dart';
import '../../data/duck_duck_go/duck_duck_go_api.dart';
import '../../data/duck_duck_go/duck_duck_go_base.dart';
import '../../data/duck_duck_go/duck_duck_go_mock.dart';
import '../../data/duck_duck_go/duck_duck_go_remote.dart';
import '../../data/network_utils/network_response_states.dart';

class CharactersListViewModel extends ChangeNotifier {
  static const _charactersFetchErrorMessage = "Characters data not available";
  String title = "";

  // Fetch either mock data or real remote data, based on global boolean.
  final DuckDuckGoAPI _duckDuckGoAPI =
      charactersListUseMockData ? DuckDuckGoMockAPI() : DuckDuckGoRemoteAPI();

  // A list of character view model objects suitable for presentation in the UI.
  List<CharacterViewModel> _characters = [];

  /// Network error message. Non-null if an error is present.
  String? errorMessage;

  /// Publicly accessible list of characters.
  List<CharacterViewModel> get characters => _characters;

  void fetchCharacters() async {
    errorMessage = null;
    final fetchedCharacters = await _duckDuckGoAPI.fetchCharacters();

    if (fetchedCharacters is SuccessState) {
      title = fetchedCharacters.value.heading;

      // We have characters. Clear out the old ones.
      _characters = [];

      // Map the raw data characters to character view models.
      for (final character in fetchedCharacters.value.characters) {
        final characterNameDescription = character.text.split('-');
        _characters.add(CharacterViewModel(
            name: characterNameDescription[0],
            imageURL: character.iconURL.isNotEmpty
                ? '${DuckDuckGoRemoteBase.imageBaseURL}${character.iconURL}'
                : '',
            description: characterNameDescription[1]));
      }
    } else if (fetchedCharacters is ErrorState) {
      errorMessage = _charactersFetchErrorMessage;
    }

    // Notify UI that new characters are available.
    notifyListeners();
  }
}

class CharacterViewModel {
  late final String name;
  late final String imageURL;
  late final String description;

  CharacterViewModel(
      {required this.name,
      this.imageURL = '',
      this.description = "No description available."});
}
