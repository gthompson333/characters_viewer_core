# characters_viewer_core
<p class='center'>
This package provides UI and logic for any app that needs a feature to show information on
television show characters.

For instance, all characters from the show "The Simpsons" or "The Wire".
</p>

## Platform Support

| Android | iOS |
| :-----: | :-: |
|   ✅    | ✅  |

## Features
- The UI of this package supports both portrait and landscape screen orientations.
- A character list screen and a character detail screen is provided.
- On phones, the detail screen will be presented as a separate screen.
- On tablets, the detail screen will be presented alongside the list screen in a typical master -
  detail navigation layout.
- A search feature is provided in the list screen that allows the user to search for all characters whose
  name and / or description contains the search text.

## Usage
To use this package, include it in your app's pubspec.

characters_viewer_core:
  git:
    url: https://github.com/gthompson333/characters_viewer_core.git

The package will be fetched directly from it's GitHub repo.

# Example
In your app's main.dart, simply call the 'launchCharacterViewer' method like this:

```dart

import 'package:characters_viewer_core/characters_viewer_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TheSimpsonsCharactersViewerApp());
}

class TheSimpsonsCharactersViewerApp extends StatelessWidget {
  const TheSimpsonsCharactersViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'The Simpsons Characters Viewer',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
    ),
    home: launchCharacterViewer(
      charactersPath: '?q=simpsons+characters&format=json',
      useMockData: true));
  }
}

```