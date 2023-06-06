import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/infracstructure.dart';


// Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl( ActorMovieDbDatasource() );
});