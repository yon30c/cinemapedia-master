import 'package:cinemapedia/infrastructure/datasources/classes.dart';
import 'package:cinemapedia/presentation/providers/animeRepoProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef AnimeCallback = Future<List<Data>> Function({int page});

final recentAnimeProvider = StateNotifierProvider<AnimesNotifier, List<Data>>((ref) {
  final fetchMoreAnime = ref.watch(animeRepoProvider).getNowPlaying;
  return AnimesNotifier(fetchMoreMovies: fetchMoreAnime);
});

final popularAnimeProvider = StateNotifierProvider<AnimesNotifier, List<Data>>((ref) {
  final fetchMoreAnime = ref.watch(animeRepoProvider).getPopular;
  return AnimesNotifier(fetchMoreMovies: fetchMoreAnime);
});

final topRateAnimeProvider = StateNotifierProvider<AnimesNotifier, List<Data>>((ref) {
  final fetchMoreAnime = ref.watch(animeRepoProvider).getTopRate;
  return AnimesNotifier(fetchMoreMovies: fetchMoreAnime);
});


class AnimesNotifier extends StateNotifier<List<Data>> {
  int currentPage = 0;
  AnimesNotifier({required this.fetchMoreMovies}) : super([]);

  bool isLoading = false;
  AnimeCallback fetchMoreMovies;

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;

    final List<Data> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies]; // state <-----

    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
  }
}
