/// Primary characters viewer core interface.
library;
import 'package:characters_viewer_core/src/business/view_models/characters_list_view_model.dart';
import 'package:characters_viewer_core/src/data/duck_duck_go/duck_duck_go_remote.dart';
import 'package:characters_viewer_core/src/ui/screens/master_detail_screen.dart';
import 'package:flutter/material.dart';

Widget launchCharacterViewer(
    {required String charactersPath, bool useMockData = false}) {
  CharactersListViewModel.useMockData = useMockData;
  DuckDuckGoRemoteAPI.createDuckDuckGoRemoteAPI(charactersPath: charactersPath);
  return MasterDetailContainer();
}
