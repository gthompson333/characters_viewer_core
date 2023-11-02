import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:characters_viewer_core/src/business/view_models/characters_list_view_model.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_remote.dart';
import 'package:characters_viewer_core/src/data/models/characters_list.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_mock.dart';
import 'package:characters_viewer_core/src/data/network_utils/network_response_states.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Fetch mock characters', () {
    test('Fetch mock characters success', () async {
      NetworkResult result = await DuckDuckGoMockAPI().fetchCharacters();
      expect(true, result is SuccessState<CharactersList>);
    });

    test('Fetch remote characters success', () async {
      CharactersListViewModel.useMockData = false;
      DuckDuckGoRemoteAPI.createDuckDuckGoRemoteAPI(
          charactersPath: '?q=simpsons+characters&format=json');

      NetworkResult result = await DuckDuckGoRemoteAPI().fetchCharacters();
      expect(true, result is SuccessState<CharactersList>);
    });
  });
}
