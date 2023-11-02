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
    try {
      final String response =
          await rootBundle.loadString('mock_data/mock_characters_data.json');

      return NetworkResult<CharactersList>.success(
          CharactersList.fromRawJson(response));
    } catch (error) {
      return NetworkResult.error(DuckDuckGoAPI.getCharactersThrownErrorMessage);
    }
  }
}
