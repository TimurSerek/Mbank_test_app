import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';

abstract class EpisodesRepository {
  Future<DataState<EpisodeEntity>> getEpisodes(FilterModel filterModel);
}
