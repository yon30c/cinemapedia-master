import 'package:cinemapedia/infrastructure/datasources/classes.dart';

import '../../infrastructure/models/anime.dart';

abstract class AnimeDatasource {
  Future<List<Data>> getNowPlaying({int page = 1});
  Future<List<Data>> getPopular({int page = 1});
  Future<List<Data>> getTopRate({int page = 1});
  Future<List<Data>> getUpcoming({int page = 1});
  Future<AnimeJK> getAnimeByUrl(String url);
}
