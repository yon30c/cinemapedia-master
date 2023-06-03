import 'package:cinemapedia/infrastructure/infracstructure.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/domain/datasources/search_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

import '../../config/constants/environment.dart';

class SearchDbDatasource extends SearchDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    final searchResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = searchResponse.results
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    return movies;
  }
}
