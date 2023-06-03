import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../domain/entities/movie.dart';

typedef SearchMovieCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final List<Movie> searchedMovies;
  List<Movie> searchMovies = [];

  final SearchMovieCallBack searchMovieCallBack;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate(
      {required this.searchMovieCallBack, required this.searchedMovies});

  void clearStreams() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debounceMovies.add(searchedMovies);
        return;
      }
      isLoadingStream.addStream(Stream.value(true));

      final result = await searchMovieCallBack(query);

      isLoadingStream.addStream(Stream.value(false));

      debounceMovies.add(result);
      searchMovies = result;
    });
  }

  Widget buildResultAndSugestion(
      {List<Movie>? initialData, Stream<List<Movie>>? stream}) {
    return StreamBuilder(
        initialData: initialData,
        stream: stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) => _MovieItem(
                    movie: movies[index],
                    onMovieSelected: (context, movie) {
                      clearStreams();
                      close(context, movie);
                    },
                  ));
        });
  }

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            

            return snapshot.data!
                ? SpinPerfect(
                    duration: const Duration(seconds: 20),
                    infinite: true,
                    spins: 10,
                    child: IconButton(
                        onPressed: () => query = '',
                        icon: const Icon(Icons.refresh_rounded)))
                : FadeIn(
                    duration: const Duration(milliseconds: 100),
                    animate: query.isNotEmpty,
                    child: IconButton(
                        onPressed: () => query = '',
                        icon: const Icon(Icons.clear)));
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultAndSugestion(
        initialData: searchMovies, stream: debounceMovies.stream);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultAndSugestion(
        initialData: searchedMovies, stream: debounceMovies.stream);
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) =>
                        FadeIn(child: child)),
              ),
            ),
            // Description
            const SizedBox(
              width: 10,
            ),

            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  movie.overview.length > 100
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      const Icon(Icons.star_half_rounded, color: Colors.amber),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style:
                            textStyle.bodySmall?.copyWith(color: Colors.amber),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
