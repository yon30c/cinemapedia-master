import 'package:cinemapedia/infrastructure/datasources/classes.dart';

class AnimeJK {
  final String description;
  final String episodes;
  final String title;
  final String imageUrl;
  final String language;
  final String state;
  final String type;
  final String url;
  final List<Chapter> chapters;
  final List<String> genres;

  AnimeJK(
      {required this.title,
      required this.description,
      required this.episodes,
      required this.genres,
      required this.language,
      required this.state,
      required this.type,
      required this.chapters,
      required this.url,
      required this.imageUrl});
}
