import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/episodes/data/data_sources/remote/episodes_api_service.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/domain/repository/episodes_repository.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';

class EpisodesRepositoryImpl extends EpisodesRepository {
  final EpisodesApiService _episodesApiService;

  EpisodesRepositoryImpl(this._episodesApiService);

  @override
  Future<DataState<EpisodeEntity>> getEpisodes(FilterModel filterModel) {
    final response = _episodesApiService.getEpisodes(filterModel);
    return response;
  }
}
