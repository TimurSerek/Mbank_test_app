import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/episodes/data/models/episode.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';

abstract class EpisodesApiService {
  Future<DataState<EpisodeModel>> getEpisodes(FilterModel filterModel);
}
