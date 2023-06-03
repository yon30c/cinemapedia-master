import 'package:cinemapedia/domain/entities/movie.dart';

abstract class SearchDatasource {
  Future<List<Movie>> searchMovies(String query);
}
