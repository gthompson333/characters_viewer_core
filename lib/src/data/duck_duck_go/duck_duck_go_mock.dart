import 'dart:async';
import 'package:flutter/services.dart';

import '../../../characters_viewer_core.dart';
import '../network_utils/network_response_states.dart';
import 'duck_duck_go_api.dart';
import '../models/characters_list.dart';

class DuckDuckGoMockAPI extends DuckDuckGoAPI {
  // Constructor is private to prevent outside instantiation.
  DuckDuckGoMockAPI._privateConstructor();

  // The one and only instance.
  static final DuckDuckGoMockAPI _sharedInstance =
      DuckDuckGoMockAPI._privateConstructor();

  factory DuckDuckGoMockAPI() => _sharedInstance;

  @override
  Future<NetworkResult> fetchCharacters() async {
    String fileName;

    // Switch on the global variant variable set by the user of this package.
    switch (charactersListVariant) {
      case CharactersListVariant.theSimpsons:
        fileName = "the_simpsons_mock_data.json";
      case CharactersListVariant.theWire:
        fileName = "the_wire_mock_data.json";
      default:
        fileName = "the_simpsons_mock_data.json";
    }

    final String response = await rootBundle.loadString('mock_data/$fileName');
    if (DuckDuckGoAPI.successStatusCode == 200) {
      return NetworkResult<CharactersList>.success(
          CharactersList.fromRawJson(response));
    } else {
      return NetworkResult.error(DuckDuckGoAPI.getCharactersErrorMessage);
    }
  }
}
