import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/datasources/classes.dart';

import '../models/anime.dart';

class AnimesRepositoryImpl extends AnimesRepository {
  final AnimeDatasource datasource;

  AnimesRepositoryImpl(this.datasource);
  @override
  Future<List<Data>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Data>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Data>> getTopRate({int page = 1}) {
    return datasource.getTopRate(page: page);
  }

  @override
  Future<List<Data>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<AnimeJK> getAnimeByUrl(String url) {
    return datasource.getAnimeByUrl(url);
  }
}
