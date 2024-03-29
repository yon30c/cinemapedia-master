import 'package:cinemapedia/infrastructure/datasources/searchdb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/search_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/infracstructure.dart';

// Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});

final searchRepositoryProvider = Provider((ref) {
  return SearchRepositoryImpl(SearchDbDatasource());
});
