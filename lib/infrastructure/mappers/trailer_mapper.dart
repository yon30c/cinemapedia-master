import 'package:cinemapedia/domain/entities/trialer.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_trialer_response.dart';

class TrialerMapper {
  static Trailer trialerToEntity(TrailerDb trailer) =>
      Trailer(name: trailer.name, key: trailer.key, id: trailer.id);
}
