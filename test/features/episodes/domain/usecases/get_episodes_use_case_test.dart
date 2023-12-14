import 'package:mbank_test_app/core/resources/data_state.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/domain/usecases/get_episodes_use_case.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/models/filter_model.dart';
import '../../../../helpers/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  late GetEpisodesUseCase getEpisodesUseCase;
  late MockEpisodesRepository mockEpisodesRepository;

  setUp((){
    mockEpisodesRepository = MockEpisodesRepository();
    getEpisodesUseCase = GetEpisodesUseCase(mockEpisodesRepository);
  });

  const episode = EpisodeEntity.empty();
  final filterModel =  FilterModel(
      pageNumber: 1
  );

  test('should get Episode from the repository', () async {
    //arrange
    when(
        mockEpisodesRepository.getEpisodes(filterModel)
    ).thenAnswer((_) async => const DataSuccess(episode));
    //act
    final result = await getEpisodesUseCase.call(params: filterModel);
    //assert
    expect(result, const DataSuccess(episode));
  });
}