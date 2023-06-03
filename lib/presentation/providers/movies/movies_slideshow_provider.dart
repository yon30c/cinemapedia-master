import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlishowProvider = Provider<List<Movie>>((ref) {
  final moviesProvider = ref.watch(nowPlayingMoviesProvider);

  if (moviesProvider.isEmpty) return [];

  return moviesProvider.sublist(0, 6);
});
