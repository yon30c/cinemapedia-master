import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/wallpaper.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: (movieDB.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
          : 'https://www.movienewz.com/img/films/poster-holder.jpg',
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: (movieDB.posterPath != 'no-poster')
          ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
          : 'https://www.movienewz.com/img/films/poster-holder.jpg',
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);

}
