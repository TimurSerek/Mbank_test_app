import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';

abstract class CharactersRepository{
  Future<DataState<CharacterEntity>> getCharacters(FilterModel filterModel);
}
