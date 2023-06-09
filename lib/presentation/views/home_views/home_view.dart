import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRateMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcoming = ref.watch(upcomingMoviesProvider);
    final popular = ref.watch(popularMoviesProvider);
    final topRate = ref.watch(topRateMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlishowProvider);

    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) {
      return const FullScreenLoader();
    }

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.symmetric(horizontal: 10),
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
                // const CustomAppBar(),
                MoviesSlideshow(movies: moviesSlideshow),
                MoviesListview(
                    title: 'En cines',
                    movies: nowPlayingMovies,
                    subtitle: 'lunes 20',
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),),
                MoviesListview(
                    title: 'Proximamente',
                    movies: upcoming,
                    subtitle: 'En cines',
                    loadNextPage: () => ref
                        .read(upcomingMoviesProvider.notifier)
                        .loadNextPage(),),
                MoviesListview(
                    title: 'Populares',
                    movies: popular,
                    loadNextPage: () => ref
                        .read(popularMoviesProvider.notifier)
                        .loadNextPage(),),
                MoviesListview(
                    title: 'Mejor calificado',
                    movies: topRate,
                    loadNextPage: () => ref
                        .read(topRateMoviesProvider.notifier)
                        .loadNextPage(),),
              ],
            );
          },
        ))
      ],
    );
  }
}
