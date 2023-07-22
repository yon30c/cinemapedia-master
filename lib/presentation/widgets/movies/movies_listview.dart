import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/infrastructure/datasources/classes.dart';
import 'package:cinemapedia/presentation/providers/animeRepoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MoviesListview extends ConsumerStatefulWidget {
  final String? subtitle;
  final String? title;
  final List<Data> movies;
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
                return FadeInRight(child: _Slide(anime: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends ConsumerWidget {
  final Data anime;
  const _Slide({required this.anime});

  @override
  Widget build(BuildContext context, ref) {
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
                anime.image.url,
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
                      onTap: () async {
                        ref
                            .read(animeRepoProvider)
                            .getAnimeByUrl(anime.link.url)
                            .then((value) =>
                                context.push('/movie/${anime.title}', extra: anime));
                      },
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
                anime.title,
                maxLines: 2,
                style: textStyle.titleSmall,
                overflow: TextOverflow.ellipsis,
              )),

          const SizedBox(
            height: 5,
          ),

          //* Rating

          // Text(
          //   anime.field2,
          //   style: textStyle.labelMedium,
          // ),
          // const SizedBox(
          //   width: 15,
          // ),
          // Text(
          //   HumanFormats.number(anime.popularity),
          //   style: textStyle.bodySmall,
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

class _PlayerOptions extends ConsumerStatefulWidget {
  const _PlayerOptions(this.servers);

  final List<PlayerData> servers;

  @override
  _PlayerOptionsState createState() => _PlayerOptionsState();
}

class _PlayerOptionsState extends ConsumerState<_PlayerOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Servidores'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.servers
                .map((e) => ListTile(
                      title: Text(e.title),
                      onTap: () => context.push('/movie/${e.title}',
                          extra: e.dataPlayer),
                    ))
                .toList()));
  }
}
