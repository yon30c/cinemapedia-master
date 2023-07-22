import 'package:cinemapedia/infrastructure/datasources/jkanime.dart';
import 'package:cinemapedia/infrastructure/infracstructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animeRepoProvider =
    Provider((ref) => AnimesRepositoryImpl(JkAnimeDatasource()));
