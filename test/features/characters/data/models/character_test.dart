import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mbank_test_app/features/characters/data/models/character.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const testCharacterModel = CharacterModel(
    count: 1,
    pages: 1,
    next: 'https://rickandmortyapi.com/api/character/?page=2',
    prev: '',
    results: [
      Character(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        episode: ['https://rickandmortyapi.com/api/episode/1'],
        url: 'https://rickandmortyapi.com/api/character/1',
        created: '2017-11-04T18:48:46.250Z',
      )
    ],
  );

  test('should be a subclass of character entity', () async {
    expect(testCharacterModel, isA<CharacterEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/mock_data/mock_character_response.json'));

    //act
    final result = CharacterModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testCharacterModel));
  });
}
