import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/delegate/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.movie_outlined,
              size: 30,
              color: color.primary,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Cinemapedia',
              style: textStyle.titleMedium,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // final searcheMovies = ref.read(searchRepositoryProvider);
                  // final searchQuery = ref.watch(searchQueryProvider);

                  showSearch<Movie?>(
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovieCallBack: ref
                                  .read(searchedMovieProvider.notifier)
                                  .searchMoviesByQuery,
                              searchedMovies: ref
                                  .watch(searchedMovieProvider.notifier)
                                  .searchedMovies))
                      .then((movie) {
                    if (movie == null) return;
                    context.push('/movie/${movie.id}');
                    ref
                        .read(searchedMovieProvider.notifier)
                        .addMovies(movie);
                  });
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
