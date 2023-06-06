import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/domain.dart';

import '../providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMovieProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) =>
        SearchedMoviesNotifier(
            searchMovies: ref.read(searchRepositoryProvider).searchMovies,
            ref: ref));

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.ref,
    required this.searchMovies,
  }) : super([]);

  List<Movie> searchedMovies = [];

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;


    return movies;
  }

  void addMovies(Movie movie) {
    if (searchedMovies.contains(movie)) {
      return;
    } else {
      searchedMovies = [movie, ...searchedMovies];
    }
  }
}
