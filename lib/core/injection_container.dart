import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:mbank_test_app/features/characters/data/data_sources/remote/characters_api_service.dart';
import 'package:mbank_test_app/features/characters/data/data_sources/remote/characters_api_service_impl.dart';
import 'package:mbank_test_app/features/characters/data/repository/characters_repository_impl.dart';
import 'package:mbank_test_app/features/characters/domain/repository/characters_repository.dart';
import 'package:mbank_test_app/features/characters/domain/usecases/get_characters_use_case.dart';
import 'package:mbank_test_app/features/characters/presentation/bloc/character/character_bloc.dart';
import 'package:mbank_test_app/features/episodes/data/data_sources/remote/episodes_api_service.dart';
import 'package:mbank_test_app/features/episodes/data/data_sources/remote/episodes_api_service_impl.dart';
import 'package:mbank_test_app/features/episodes/data/repository/episodes_repository_impl.dart';
import 'package:mbank_test_app/features/episodes/domain/repository/episodes_repository.dart';
import 'package:mbank_test_app/features/episodes/domain/usecases/get_episodes_use_case.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/episode/episode_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Data sources
  sl.registerSingleton<CharactersApiService>(CharactersApiServiceImpl());
  sl.registerSingleton<EpisodesApiService>(EpisodesApiServiceImpl());

  //Repositories
  sl.registerSingleton<CharactersRepository>(
      CharactersRepositoryImpl(sl()));

  sl.registerSingleton<EpisodesRepository>(
      EpisodesRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetCharactersUseCase>(GetCharactersUseCase(sl()));
  sl.registerSingleton<GetEpisodesUseCase>(GetEpisodesUseCase(sl()));

  //Blocs
  sl.registerSingleton<CharacterBloc>(CharacterBloc(sl()));
  sl.registerSingleton<EpisodeBloc>(EpisodeBloc(sl()));
}
