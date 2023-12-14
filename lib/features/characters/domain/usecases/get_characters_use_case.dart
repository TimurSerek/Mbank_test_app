import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/core/usecases/usecase.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/domain/repository/characters_repository.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';

class GetCharactersUseCase implements UseCase<DataState<CharacterEntity>, FilterModel> {
  final CharactersRepository _charactersRepository;

  GetCharactersUseCase(this._charactersRepository);

  @override
  Future<DataState<CharacterEntity>> call({FilterModel? params}) {
    return _charactersRepository.getCharacters(params!);
  }
}