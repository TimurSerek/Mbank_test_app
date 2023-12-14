import 'package:mbank_test_app/features/characters/domain/entities/character.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    int? count,
    int? pages,
    String? next,
    String? prev,
    List<Character>? results,
  }) : super(
          next: next,
          results: results,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        count: json['info']['count'],
        pages: json['info']['pages'],
        next: json['info']['next'],
        prev: json['info']['prev'],
        results: (json['results'] as List)
            .map((episodeJson) => Character.fromJson(episodeJson))
            .toList(),
      );
}
