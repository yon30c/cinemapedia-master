import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MoviesListview extends ConsumerStatefulWidget {
  final String? subtitle;
  final String? title;
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MoviesListview(
      {super.key,
      this.title,
      required this.movies,
      this.subtitle,
      this.loadNextPage});

  @override
  MoviesListviewState createState() => MoviesListviewState();
}

class MoviesListviewState extends ConsumerState<MoviesListview> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(
              title: widget.title,
              subtitle: widget.subtitle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Esto es la imagen
          SizedBox(
            width: 150,
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}') ,
                    child: FadeIn(child: child));
                },
              ),
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          //* Este es el titulo

          SizedBox(
              width: 150,
              child: Text(
                movie.title,
                maxLines: 2,
                style: textStyle.titleSmall,
                overflow: TextOverflow.ellipsis,
              )),

          const SizedBox(
            height: 5,
          ),

          //* Rating

          Row(
            children: [
              const Icon(
                Icons.star_half_outlined,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${movie.voteAverage}',
                style: textStyle.bodyMedium?.copyWith(color: Colors.amber),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                HumanFormats.number(movie.popularity),
                style: textStyle.bodySmall,
              )
              // Text('${  movie.popularity}' , style: textStyle.bodyMedium,)
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: textStyle.titleLarge,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subtitle!))
        ],
      ),
    );
  }
}
