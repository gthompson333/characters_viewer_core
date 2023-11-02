import 'dart:async';
import 'package:http/http.dart';
import 'duck_duck_go_base.dart';
import 'duck_duck_go_api.dart';
import '../network_utils/network_response_states.dart';
import '../network_utils/network_utils.dart';
import '../models/characters_list.dart';

class DuckDuckGoRemoteAPI extends DuckDuckGoAPI {
  // Private

  // Constructor is private to prevent outside instantiation.
  DuckDuckGoRemoteAPI._privateConstructor();

  // The one and only instance.
  static final DuckDuckGoRemoteAPI _sharedInstance =
      DuckDuckGoRemoteAPI._privateConstructor();

  factory DuckDuckGoRemoteAPI() => _sharedInstance;

  // Public

  // Callers use this creator method to instantiate the Duck Duck Go remote
  // API object and must provide a Duck Duck Go URL path.
  static createDuckDuckGoRemoteAPI({required String charactersPath}) {
    _sharedInstance.charactersPath = charactersPath;
  }

  DuckDuckGoRemoteBase remoteBase = DuckDuckGoRemoteBase(Client());
  late final String charactersPath;

  @override
  Future<NetworkResult> fetchCharacters() async {
    try {
      final response = await remoteBase.request(
          action: RequestAction.get, path: charactersPath);

      // If network request is successful.
      // TODO: Might want to handle other 2xx status codes also.
      if (response.statusCode == 200) {
        return NetworkResult<CharactersList>.success(
            CharactersList.fromRawJson(response.body));
      } else {
        return NetworkResult.error(DuckDuckGoAPI.getCharactersErrorMessage);
      }
    } catch (error) {
      return NetworkResult.error(DuckDuckGoAPI.getCharactersThrownErrorMessage);
    }
  }
}
