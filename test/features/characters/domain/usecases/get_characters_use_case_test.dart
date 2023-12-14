import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/domain/usecases/get_characters_use_case.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/models/filter_model.dart';
import '../../../../helpers/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  late GetCharactersUseCase getCharactersUseCase;
  late MockCharactersRepository mockCharactersRepository;

  setUp((){
    mockCharactersRepository = MockCharactersRepository();
    getCharactersUseCase = GetCharactersUseCase(mockCharactersRepository);
  });

  const character = CharacterEntity.empty();
  final filterModel =  FilterModel(
      pageNumber: 1
  );
  
  test('should get Character from the repository', () async {
    //arrange
    when(
        mockCharactersRepository.getCharacters(filterModel)
    ).thenAnswer((_) async => const DataSuccess(character));
    //act
    final result = await getCharactersUseCase.call(params: filterModel);
    //assert
    expect(result, const DataSuccess(character));
  });
}