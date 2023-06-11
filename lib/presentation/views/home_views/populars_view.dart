import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';

class PopularView extends ConsumerStatefulWidget {
  static const String name = 'Home-screen';

  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final movies = ref.watch(popularMoviesProvider);
    return Center(
      child: MovieMasonry(
          loadNextPage: () =>
              ref.read(popularMoviesProvider.notifier).loadNextPage(),
          movies: movies),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
