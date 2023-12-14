import 'package:dio/dio.dart';
import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/data/models/character.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';
import 'characters_api_service.dart';

class CharactersApiServiceImpl extends CharactersApiService {
  Dio dio = Dio();

  @override
  Future<DataState<CharacterModel>> getCharacters(
      FilterModel filterModel) async {
    try {
      String url = 'https://rickandmortyapi.com/api/character/?page=${filterModel.pageNumber}&name=${filterModel.name}&species=${filterModel.specie}';
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        final character = CharacterModel.fromJson(response.data);
        return DataSuccess(character);
      } else {
        return DataFailed(DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
