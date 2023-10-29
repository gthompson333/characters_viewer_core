import '../network_utils/network_response_states.dart';

abstract class DuckDuckGoAPI {
  static const getCharactersErrorMessage = "Get characters network error.";
  static const getCharactersThrownErrorMessage = "Get characters error thrown.";
  static const successStatusCode = 200;

  // Any class that implements a Duck Duck Go API needs to implement this method.
  Future<NetworkResult> fetchCharacters();
}
