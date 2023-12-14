import 'package:flutter/material.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  const EpisodeDetailsScreen({Key? key, required this.episode})
      : super(key: key);

  final Episode episode;

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.episode.name ?? '')),
        body: _Body(episode: widget.episode));
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(episode.name ?? ''),
          const SizedBox(height: 20.0),
          Text(episode.episode ?? ''),
          const SizedBox(height: 10.0),
          Text(episode.created ?? ''),
        ],
      ),
    );
  }
}
