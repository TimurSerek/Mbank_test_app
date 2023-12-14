import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/domain/usecases/get_episodes_use_case.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';
import 'package:stream_transform/stream_transform.dart';
import 'episode_event.dart';
import 'episode_state.dart';


EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetEpisodesUseCase _getEpisodesUseCase;
  final PagingController<int, Episode> pagingController =
  PagingController(firstPageKey: 0);
  FilterModel filterModel = FilterModel();
  String? nextPage = '';

  EpisodeBloc(this._getEpisodesUseCase) : super(const EpisodeInitial()){
    on<PagingEpisodeEvent>(_onPagingEpisodes);
    on<SearchEpisodeEvent>(_onSearchEpisodes,
        transformer: debounceDroppable(
          const Duration(milliseconds: 500),
        ));
  }

  void _onPagingEpisodes(PagingEpisodeEvent event, Emitter <EpisodeState> emit) async {
    if(event.pageNumber != null){

      filterModel.pageNumber = event.pageNumber!;

      final dataState = await _getEpisodesUseCase(params: filterModel);
      if (dataState is DataSuccess && dataState.data != null && dataState.data!.results!.isNotEmpty) {
        nextPage = dataState.data?.next;
        if(nextPage != null){
          pagingController.appendPage(dataState.data!.results!, event.pageNumber! + 1);
        } else {
          pagingController.appendLastPage(dataState.data!.results!);
        }
      }
    }
  }

  void _onSearchEpisodes(SearchEpisodeEvent event, Emitter <EpisodeState> emit) async {
    if(event.searchQuery != null){

      filterModel.name = event.searchQuery!;
      filterModel.pageNumber = 0;

      final dataState = await _getEpisodesUseCase(params: filterModel);
      if (dataState is DataSuccess && dataState.data != null && dataState.data!.results!.isNotEmpty) {
        nextPage = dataState.data?.next;
        if(nextPage != null){
          pagingController.value = PagingState<int, Episode>(
              itemList: dataState.data!.results, nextPageKey: 1);
        } else {
          pagingController.value = PagingState<int, Episode>(
              itemList: dataState.data!.results);
        }
      }
    }
  }
}
