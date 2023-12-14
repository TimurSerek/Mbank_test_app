import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';

class EpisodeModel extends EpisodeEntity {
  const EpisodeModel({
    int? count,
    int? pages,
    String? next,
    String? prev,
    List<Episode>? results,
  }) : super(
          next: next,
          results: results,
        );

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      count: json['info']['count'],
      pages: json['info']['pages'],
      next: json['info']['next'],
      prev: json['info']['prev'],
      results: (json['results'] as List)
          .map((episodeJson) => Episode.fromJson(episodeJson))
          .toList(),
    );
  }
}

