import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/infracstructure.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      // headers: {
      //   'Authorization' :'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMDBiZGM4ZmZhMzhhZTI2N2VjOTQwNWZkNzI2ZjkxOCIsInN1YiI6IjY0MjVmOWFiMDFiMWNhMDA5N2ZjYjdmNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qcRdQHLpznQzfFkbhhbUMNjN4v01RI7HJya6wuKT-_Q'
      // },
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  // https://api.themoviedb.org/3/movie/now_playing?api_key=000bdc8ffa38ae267ec9405fd726f918

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getTopRate({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    return movies;
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    final detailsResponse = Details.fromJson(response.data);

    final Movie movie = MovieDetailsMapper.movieDetailsToEntity(detailsResponse) ;

    return movie;
  }
}
