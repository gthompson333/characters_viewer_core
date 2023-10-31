import 'dart:async';
import 'package:flutter/services.dart';
import '../network_utils/network_response_states.dart';
import 'duck_duck_go_api.dart';
import '../models/characters_list.dart';

class DuckDuckGoMockAPI extends DuckDuckGoAPI {
  // Private

  // Constructor is private to prevent outside instantiation.
  DuckDuckGoMockAPI._privateConstructor();

  // Public
  // The one and only instance.
  static final DuckDuckGoMockAPI _sharedInstance =
      DuckDuckGoMockAPI._privateConstructor();

  factory DuckDuckGoMockAPI() => _sharedInstance;

  @override
  Future<NetworkResult> fetchCharacters() async {
    final String response = await rootBundle.loadString('mock_data/mock_characters_data.json');

    if (DuckDuckGoAPI.successStatusCode == 200) {
      return NetworkResult<CharactersList>.success(
          CharactersList.fromRawJson(response));
    } else {
      return NetworkResult.error(DuckDuckGoAPI.getCharactersErrorMessage);
    }
  }
}
