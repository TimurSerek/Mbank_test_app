import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  final String? searchQuery;
  final String? specie;
  final int? pageNumber;

  const CharacterEvent({this.searchQuery, this.pageNumber, this.specie});

  @override
  List<Object?> get props => [searchQuery, pageNumber, specie];
}

class SearchCharacterEvent extends CharacterEvent {
  const SearchCharacterEvent(String? searchQuery) : super(searchQuery: searchQuery);
  }

class PagingCharacterEvent extends CharacterEvent {
  const PagingCharacterEvent(int? pageNumber) : super(pageNumber: pageNumber);
}

class SpeciesCharacterEvent extends CharacterEvent {
  const SpeciesCharacterEvent(String? specie) : super(specie: specie);
}

class ClearFilterCharacterEvent extends CharacterEvent {
  const ClearFilterCharacterEvent();
}

