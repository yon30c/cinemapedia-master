import 'package:cinemapedia/domain/domain.dart';

abstract class MoviesDatasource {
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRate({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Video>> getYoutubeVideo(int movieId);
}
