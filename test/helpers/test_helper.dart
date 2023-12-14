import 'package:mbank_test_app/features/characters/data/data_sources/remote/characters_api_service.dart';
import 'package:mbank_test_app/features/characters/domain/repository/characters_repository.dart';
import 'package:mbank_test_app/features/episodes/data/data_sources/remote/episodes_api_service.dart';
import 'package:mbank_test_app/features/episodes/domain/repository/episodes_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

@GenerateMocks(
  [
    CharactersRepository,
    CharactersApiService,
    EpisodesRepository,
    EpisodesApiService,
    Dio
  ],
)
void main(){}