import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/infrastructure/datasources/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';

  final Data anime;
  
  const AnimeScreen({super.key, required this.anime});


  @override
  AnimeScreenState createState() => AnimeScreenState();
}

class AnimeScreenState extends ConsumerState<AnimeScreen> {

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    // final PlayerData anime = ref.watch();

    // if (anime == null) {
    //   return const Scaffold(
    //       body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    // }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomSliverAppBar(movie: widget.anime),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _AnimeDetails(anime: widget.anime, ),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _AnimeDetails extends StatelessWidget {
  final Data anime;

  const _AnimeDetails({required this.anime,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  anime.image.url,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(anime.title, style: textStyles.titleLarge),
                    Text(anime.description),
                  ],
                ),
              )
            ],
          ),
        ),

        // Expanded(
        //   child: ListView.builder(
        //     itemCount: ,
        //     itemBuilder: (BuildContext context, int index) {
        //       return ;
        //     },
        //   ),
        // ),

        // Generos de la película
        


        // _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 50),
      ],
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {
  final Data movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.image.url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
           
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),
          ],
        ),
      ),
    );
  }
}
