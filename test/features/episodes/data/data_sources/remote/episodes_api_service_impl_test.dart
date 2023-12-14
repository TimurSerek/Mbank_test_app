import 'package:dio/dio.dart';
import 'package:mbank_test_app/core/constants/constants.dart';
import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mbank_test_app/features/episodes/data/data_sources/remote/episodes_api_service_impl.dart';
import 'package:mbank_test_app/features/episodes/data/models/episode.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../../helpers/json_reader.dart';
import '../../../../../helpers/test_helper.mocks.dart';

void main(){
  late EpisodesApiServiceImpl episodesApiServiceImpl;
  late MockDio mockDio;

  setUp((){
    mockDio = MockDio();
    episodesApiServiceImpl = EpisodesApiServiceImpl();
  });

  final filterModel =  FilterModel(
    name:'',
    pageNumber: 1,
  );
  group('get Episode model', () {
    test('should return episode model when the response code is 200', () async {
      //arrange
      when(
          mockDio.get(
              Urls.episodeModel(pageNumber: filterModel.pageNumber, name: filterModel.name)
          )
      ).thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: readJson('helpers/dummy_data/dummy_episode_response.json'),
          statusCode: 200,
        ),
      );
      //act

      final result = await episodesApiServiceImpl.getEpisodes(filterModel);
      //assert
      expect(result, isA<DataSuccess<EpisodeModel>>());
    });
  });
}