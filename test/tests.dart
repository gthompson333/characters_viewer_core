import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_remote.dart';
import 'package:characters_viewer_core/src/data/models/characters_list.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_mock.dart';
import 'package:characters_viewer_core/src/data/network_utils/network_response_states.dart';
import 'package:characters_viewer_core/src/business/view_models/characters_list_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Fetch characters', () {
    test('Fetch mock characters success', () async {
      NetworkResult result = await DuckDuckGoMockAPI().fetchCharacters();
      expect(result is SuccessState<CharactersList>, true);
    });

    test('Fetch remote characters success', () async {
      CharactersListViewModel.useMockData = false;
      DuckDuckGoRemoteAPI.createDuckDuckGoRemoteAPI(
          charactersPath: '?q=simpsons+characters&format=json');

      NetworkResult result = await DuckDuckGoRemoteAPI().fetchCharacters();
      expect(result is SuccessState<CharactersList>, isTrue);
    });
  });
}
