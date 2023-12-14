class Urls {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  static String characterModel({required String name, required String specie, required int pageNumber}) =>
      '$baseUrl/character/?page=$pageNumber&name=$name&species=$specie';

  static String episodeModel({required String name, required int pageNumber}) =>
      '$baseUrl/episode/?page=$pageNumber&name=$name';
}

