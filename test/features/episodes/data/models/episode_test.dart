import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mbank_test_app/features/episodes/data/models/episode.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const testEpisodeModel = EpisodeModel(
    count: 51,
    pages: 3,
    next: 'https://rickandmortyapi.com/api/episode/?page=2',
    prev: null,
    results: [Episode(
      id: 1,
      name: 'Pilot',
      airDate: 'December 2, 2013',
      episode: 'S01E01',
      characters: ['https://rickandmortyapi.com/api/character/1'],
      url: 'https://rickandmortyapi.com/api/episode/1',
      created:'2017-11-10T12:56:33.798Z',
    )],
  );

  test('should be a subclass of episode entity', () async {
    expect(testEpisodeModel, isA<EpisodeEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
    json.decode(readJson('helpers/mock_data/mock_episode_response.json'));

    //act
    final result = EpisodeModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testEpisodeModel));
  });
}