import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String? next;
  final List<Character>? results;

  const CharacterEntity({
    required this.next,
    required this.results,
  });

  @override
  List<Object?> get props => [next, results];

  const CharacterEntity.empty()
      : this(
          next: '',
          results: const [],
        );
}

class Character extends Equatable {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final String? image;
  final List<String>? episode;
  final String? url;
  final String? created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        episode,
        url,
        created,
      ];

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        image: json['image'],
        episode: List<String>.from(json['episode']),
        url: json['url'],
        created: json['created'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'image': image,
        'episode': episode,
        'url': url,
        'created': created,
      };
}

class Origin extends Equatable {
  final String name;
  final String url;

  const Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };

  @override
  List<Object?> get props => [name, url];
}

class Location extends Equatable {
  final String name;
  final String url;

  const Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };

  @override
  List<Object?> get props => [name, url];
}
