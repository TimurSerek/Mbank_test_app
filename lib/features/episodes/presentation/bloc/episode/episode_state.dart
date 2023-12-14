import 'package:equatable/equatable.dart';

abstract class EpisodeState extends Equatable {
  final String? message;

  const EpisodeState({this.message});

  @override
  List<Object?> get props => [message];
}

class EpisodeInitial extends EpisodeState {
  const EpisodeInitial();
}

