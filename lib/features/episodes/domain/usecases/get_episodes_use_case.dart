import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/core/usecases/usecase.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/domain/repository/episodes_repository.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';

class GetEpisodesUseCase implements UseCase<DataState<EpisodeEntity>, FilterModel> {
  final EpisodesRepository _episodesRepository;

  GetEpisodesUseCase(this._episodesRepository);

  @override
  Future<DataState<EpisodeEntity>> call({FilterModel? params}) {
    return _episodesRepository.getEpisodes(params!);
  }
}