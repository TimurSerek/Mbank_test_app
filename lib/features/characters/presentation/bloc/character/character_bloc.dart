import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/domain/usecases/get_characters_use_case.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/character/character_event.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';
import 'package:stream_transform/stream_transform.dart';
import 'character_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersUseCase _getCharactersUseCase;
  final PagingController<int, Character> pagingController =
  PagingController(firstPageKey: 0);
  FilterModel filterModel = FilterModel();
  String? nextPage = '';


  CharacterBloc(this._getCharactersUseCase) : super(const CharacterInitialState()){
    on<PagingCharacterEvent>(_onPagingCharacters);
    on<SearchCharacterEvent>(_onSearchCharacters,
      transformer: debounceDroppable(
      const Duration(milliseconds: 500),
    ));
    on<SpeciesCharacterEvent>(_onFilterSpeciesCharacters);
    on<ClearFilterCharacterEvent>(_onClearFilterCharacters);
  }

  void _onPagingCharacters(PagingCharacterEvent event, Emitter <CharacterState> emit) async {
    if(event.pageNumber != null){

      filterModel.pageNumber = event.pageNumber!;

      final dataState = await _getCharactersUseCase(params: filterModel);
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

  void _onSearchCharacters(SearchCharacterEvent event, Emitter <CharacterState> emit) async {
    if(event.searchQuery != null){

      filterModel.name = event.searchQuery!;
      filterModel.pageNumber = 0;

      await _getFilteredCharacters(filterModel);
    }
  }

  void _onFilterSpeciesCharacters(SpeciesCharacterEvent event, Emitter <CharacterState> emit) async {
    if(event.specie != null && event.specie!.isNotEmpty){
      filterModel.specie = event.specie!;
      filterModel.pageNumber = 0;

      await _getFilteredCharacters(filterModel);
    }
  }

  _onClearFilterCharacters(ClearFilterCharacterEvent event, Emitter <CharacterState> emit) async {
    filterModel.specie = '';
    filterModel.pageNumber = 0;
    await _getFilteredCharacters(filterModel);
  }

  _getFilteredCharacters(FilterModel filterModel) async {
    final dataState = await _getCharactersUseCase(params: filterModel);
    if (dataState is DataSuccess && dataState.data != null && dataState.data!.results!.isNotEmpty) {
      nextPage = dataState.data?.next;
      if(nextPage != null){
        pagingController.value = PagingState<int, Character>(
            itemList: dataState.data!.results, nextPageKey: 1);
      } else {
        pagingController.value = PagingState<int, Character>(
            itemList: dataState.data!.results);
      }
    }
  }
}



