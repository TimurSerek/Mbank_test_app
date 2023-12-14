import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mbank_test_app/features/characters/domain/entities/character.dart';
import 'package:mbank_test_app/features/characters/presentation/pages/character_details.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/presentation/pages/episodes_details.dart';
import 'package:mbank_test_app/main/main_screen.dart';

class AppPages {
  static const toMainScreen = '/';
  static const toCharacterDetails = 'characterDetails';
  static const toEpisodeDetails = 'episodeDetails';
}

class AppRouter {
  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'characterDetails',
            name: 'characterDetails',
            builder: (BuildContext context, GoRouterState state) {
              final character = state.extra as Character;
              return CharacterDetailsScreen(character: character);
            },
          ),
          GoRoute(
            path: 'episodeDetails',
            name: 'episodeDetails',
            builder: (BuildContext context, GoRouterState state) {
              final episode = state.extra as Episode;
              return EpisodeDetailsScreen(episode: episode);
            },
          ),
        ],
      ),
    ],
  );
}
