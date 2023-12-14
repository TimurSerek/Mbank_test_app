import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mbank_test_app/core/constants/strings.dart';
import 'package:mbank_test_app/core/injection_container.dart';
import 'package:mbank_test_app/core/routes/routes.dart';
import 'package:mbank_test_app/features/episodes/domain/entities/episode.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/episode/episode_bloc.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/episode/episode_event.dart';
import 'package:mbank_test_app/features/episodes/presentation/bloc/episode/episode_state.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppStrings.episodes)),
      ),
      body: BlocProvider<EpisodeBloc>(
        create: (context) => sl(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeBloc, EpisodeState>(builder: (_, state) {
      return const  Column(
        children: [
          SizedBox(height: 10),
          _SearchField(),
          SizedBox(height: 10),
          _CharacterListWidget(),
        ],
      );
    });
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          BlocProvider.of<EpisodeBloc>(context)
              .add(SearchEpisodeEvent(value));
        },
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: Colors.grey.shade200,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          hintText: AppStrings.searchEpisodes,
          hintStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class _CharacterListWidget extends StatefulWidget {
  const _CharacterListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<_CharacterListWidget> {

  @override
  void initState() {
    final bloc = BlocProvider.of<EpisodeBloc>(context);
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.add(PagingEpisodeEvent(pageKey));
    });
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<EpisodeBloc>(context).pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EpisodeBloc>(context);
    return Expanded(
      child: PagedListView<int, Episode>(
          pagingController: bloc.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Episode>(
              itemBuilder: (context, episode, index) => _ItemListWidget(
                episode: episode,
              ))),
    );
  }
}

class _ItemListWidget extends StatelessWidget {
  const _ItemListWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode? episode;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: GestureDetector(
          onTap: (){
            context.goNamed(
              AppPages.toEpisodeDetails,
              extra: episode,
            );
          },
          child:  Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episode?.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          episode?.created ?? '',
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          episode?.episode ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}


