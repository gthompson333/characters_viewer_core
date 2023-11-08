import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_remote.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_mock.dart';
import 'package:characters_viewer_core/src/data/network_utils/network_response_states.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Fetch characters success', () {
    test('Fetch mock characters success', () async {
      // Use the mock api object for this test.
      // The mock api object knows to look for the 'mock_data/mock_characters_data.json' file.
      NetworkResult result = await DuckDuckGoMockAPI().fetchCharacters();
      expect(result is SuccessState, true);
    });

    test('Fetch remote characters success', () async {
      // Provide any Duck Duck Go query param that returns data in the expected format.
      DuckDuckGoRemoteAPI.createDuckDuckGoRemoteAPI(
          charactersPath: '?q=simpsons+characters&format=json');

      NetworkResult result = await DuckDuckGoRemoteAPI().fetchCharacters();
      expect(result is SuccessState, isTrue);
    });
  });

  group('Fetch characters fail', () {
    test('Fetch remote characters fail', () async {
      // Provide any Duck Duck Go query param that returns data in the expected format.
      DuckDuckGoRemoteAPI.createDuckDuckGoRemoteAPI(
          charactersPath: '?a=simpsons+characters&format=json');

      NetworkResult result = await DuckDuckGoRemoteAPI().fetchCharacters();
      expect(result is ErrorState, isTrue);
    });
  });
}
