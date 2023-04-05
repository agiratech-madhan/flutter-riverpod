// ignore_for_file: public_member_api_docs, sort_constructors_first
class GenresList {
  final List<Genres> genres;
  GenresList({
    required this.genres,
  });
  factory GenresList.fromJson(Map<String, dynamic> json) {
    List genresData = json['genres'];
    List<Genres> value = genresData.map((e) => Genres.fromJson(e)).toList();
    return GenresList(genres: value);
  }
}

class Genres {
  final int id;
  final String name;
  bool selected;
  Genres({
    required this.id,
    required this.name,
    this.selected = false,
  });
  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}
