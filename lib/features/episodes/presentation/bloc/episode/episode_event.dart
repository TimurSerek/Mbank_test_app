import 'package:equatable/equatable.dart';

abstract class EpisodeEvent extends Equatable {
  final String? searchQuery;
  final int? pageNumber;

  const EpisodeEvent({this.searchQuery, this.pageNumber});

  @override
  List<Object?> get props => [searchQuery, pageNumber];
}

class PagingEpisodeEvent extends EpisodeEvent {
  const PagingEpisodeEvent(int? pageNumber) : super(pageNumber: pageNumber);
}

class SearchEpisodeEvent extends EpisodeEvent {
  const SearchEpisodeEvent(String? searchQuery) : super(searchQuery: searchQuery);
}

