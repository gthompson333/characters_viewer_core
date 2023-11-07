import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:characters_viewer_core/src/business/view_models/characters_list_view_model.dart';
import 'package:characters_viewer_core/src/ui/screens/characters_list_screen.dart';

main() {
  setUp(() {
    CharactersListViewModel.useMockData = true;
  });

  testWidgets('Show the characters list.', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: CharactersListScreen(characterSelectedCallback: (c) {})));
  });
}
