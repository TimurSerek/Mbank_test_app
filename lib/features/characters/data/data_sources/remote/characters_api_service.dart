import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/data/models/character.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';

abstract class CharactersApiService{
  Future<DataState<CharacterModel>> getCharacters(FilterModel filterModel);
}