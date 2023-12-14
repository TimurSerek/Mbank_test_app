import 'package:equatable/equatable.dart';

abstract class CharacterState extends Equatable {
  final String? message;

  const CharacterState({this.message});

  @override
  List<Object?> get props => [message];
}

class CharacterInitialState extends CharacterState {
  const CharacterInitialState();
}

class CharacterSearchState extends CharacterState {
  const CharacterSearchState(String message) : super(message: message);
}
