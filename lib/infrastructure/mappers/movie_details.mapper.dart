import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/infracstructure.dart';

class MovieDetailsMapper {
  static Movie movieDetailsToEntity(Details movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath:( movieDB.backdropPath != '') 
          ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg' ,
      genreIds: movieDB.genres.map((e) => e.name).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: ( movieDB.posterPath != '') 
          ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg' ,
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount
    );
}
