import 'package:dio/dio.dart';
import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/episodes/data/models/episode.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';
import 'episodes_api_service.dart';

class EpisodesApiServiceImpl extends EpisodesApiService{
  Dio dio = Dio();

  @override
  Future<DataState<EpisodeModel>> getEpisodes(FilterModel filterModel) async {
    String url = 'https://rickandmortyapi.com/api/episode/?page=${filterModel.pageNumber}&name=${filterModel.name}';
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        final episode = EpisodeModel.fromJson(response.data);
        return DataSuccess(episode);
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