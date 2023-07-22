import 'package:cinemapedia/presentation/widgets/movies/movies_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

import '../../providers/animeProvider.dart';
import '../../providers/initial_loading.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen'; //Escriba el nombre de la ruta

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(recentAnimeProvider.notifier).loadNextPage();
    ref.read(popularAnimeProvider.notifier).loadNextPage();
    ref.read(topRateAnimeProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // if ( ref.watch(getepisodesProvider.notifier).episodesArray.isEmpty ) {
    //   return const FullScreenLoader();
    final initialLoading = ref.watch(initialLoadingProvider);
    // }

    if (initialLoading) {
      return const FullScreenLoader();
    }

    final recentAnimes = ref.watch(recentAnimeProvider);
    final popularAnimes = ref.watch(popularAnimeProvider);
    final topRateAnimes = ref.watch(topRateAnimeProvider);


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
                MoviesSlideshow(animes: topRateAnimes),
                MoviesListview(
                  title: 'En emisión',
                  movies: recentAnimes,
                  subtitle: 'Recientes',
                ),
                MoviesListview(
                    title: 'Destacados',
                    movies: popularAnimes,
                  ),
                // MoviesListview(
                //     title: 'Populares',
                //     movies: topRateAnimes,
                //   ),
                // MoviesListview(
                //     title: 'Mejor calificado',
                //     movies: topRate,
                //     loadNextPage: () => ref
                //         .read(topRateMoviesProvider.notifier)
                //         .loadNextPage()),
              ],
            );
          },
        ))
      ],
    );
  }
}
