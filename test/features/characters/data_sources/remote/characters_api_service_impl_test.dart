import 'package:dio/dio.dart';
import 'package:mbank_test_app/core/constants/constants.dart';
import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/data/data_sources/remote/characters_api_service_impl.dart';
import 'package:mbank_test_app/features/characters/data/models/character.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

void main(){
  late CharactersApiServiceImpl charactersApiServiceImpl;
  late MockDio mockDio;

  setUp((){
    mockDio = MockDio();
    charactersApiServiceImpl = CharactersApiServiceImpl();
  });

  final filterModel =  FilterModel(
      name:'',
      specie:'',
      pageNumber: 1,
  );
  
  group('get Character model', () {
    test('should return character model when the response code is 200', () async {
      //arrange
      when(
          mockDio.get(
              Urls.characterModel(pageNumber: filterModel.pageNumber, name: filterModel.name, specie: filterModel.specie)
          )
      ).thenAnswer(
              (_) async => Response(
                requestOptions: RequestOptions(path: ''),
                data: readJson('helpers/dummy_data/dummy_weather_response.json'),
                statusCode: 200,
              ),
      );
      //act

      final result = await charactersApiServiceImpl.getCharacters(filterModel);
      //assert
      expect(result, isA<DataSuccess<CharacterModel>>());
    });
  });
}