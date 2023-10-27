import 'dart:async';
import 'package:http/http.dart';
import 'duck_duck_go_base.dart';
import 'duck_duck_go_api.dart';

import '../../../characters_viewer_core.dart';
import '../network_utils/network_response_states.dart';
import '../network_utils/network_utils.dart';
import '../models/characters_list.dart';

class DuckDuckGoRemoteAPI extends DuckDuckGoAPI {
  // Constructor is private to prevent outside instantiation.
  DuckDuckGoRemoteAPI._privateConstructor();

  // The one and only instance.
  static final DuckDuckGoRemoteAPI _sharedInstance =
      DuckDuckGoRemoteAPI._privateConstructor();

  factory DuckDuckGoRemoteAPI() => _sharedInstance;
  final DuckDuckGoRemoteBase _client = DuckDuckGoRemoteBase(Client());

  @override
  Future<NetworkResult> fetchCharacters() async {
    String localPath;

    // Switch on the global variant variable set by the user of this package.
    switch (charactersListVariant) {
      case CharactersListVariant.theSimpsons:
        localPath = "?q=simpsons+characters&format=json";
      case CharactersListVariant.theWire:
        localPath = "?q=the+wire+characters&format=json";
      default:
        localPath = "?q=star+trek+characters&format=json";
    }

    try {
      final response = await _client.request(
          action: RequestAction.get,
          path: localPath );

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
