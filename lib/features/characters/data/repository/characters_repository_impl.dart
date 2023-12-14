import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/data/data_sources/remote/characters_api_service.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/domain/repository/characters_repository.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';

class CharactersRepositoryImpl extends CharactersRepository {
  final CharactersApiService _charactersApiService;

  CharactersRepositoryImpl(this._charactersApiService);

  @override
  Future<DataState<CharacterEntity>> getCharacters(
      FilterModel filterModel) {
    final response = _charactersApiService.getCharacters(filterModel);
    return response;
  }
}
