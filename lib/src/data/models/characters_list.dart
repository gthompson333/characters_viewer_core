// Data model for a list of characters.
import 'dart:convert';

class CharactersList {
  static const _headingKey = 'Heading';
  static const _relatedTopicsKey = 'RelatedTopics';

  final String heading;
  final List<Character> characters;

  CharactersList({this.heading = "", this.characters = const []});

  factory CharactersList.fromRawJson(String str) =>
      CharactersList.fromJson(json.decode(str));

  factory CharactersList.fromJson(Map<String, dynamic> json) => CharactersList(
      heading: json[_headingKey],
      characters: List<Character>.from(json[_relatedTopicsKey]
          .map((character) => Character.fromJson(character))));
}

// Data model for a single character.
class Character {
  static const _iconKey = 'Icon';
  static const _iconURLKey = 'URL';
  static const _textKey = 'Text';
  late final String iconURL;
  late final String text;

  Character({this.iconURL = '', this.text = ''});

  factory Character.fromJson(Map<String, dynamic> json) =>
      Character(iconURL: json[_iconKey][_iconURLKey], text: json[_textKey]);
}
