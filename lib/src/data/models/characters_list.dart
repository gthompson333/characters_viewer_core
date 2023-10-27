import 'dart:convert';

// Data model for a list of characters.
class CharactersList {
  static const _relatedTopicsKey = "RelatedTopics";
  final List<Character> characters;

  CharactersList({required this.characters});

  factory CharactersList.fromRawJson(String str) =>
      CharactersList.fromJson(json.decode(str));

  factory CharactersList.fromJson(Map<String, dynamic> json) => CharactersList(
      characters: List<Character>.from(
          json[_relatedTopicsKey].map((x) => Character.fromJson(x))));
}

// Data model for a single character.
class Character {
  static const _textKey = 'Text';
  late final String text;

  Character({required this.text});
  Character.fromJson(Map<String, dynamic> json) : text = json[_textKey];
}
