import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../infrastructure/datasources/classes.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Data> animes;
  const MoviesSlideshow({super.key, required this.animes});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Swiper(
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: color.primary,
              color: color.secondary,
            )),
        viewportFraction: 0.5,
        itemCount: animes.length,
        scale: 0.5,
        autoplay: true,
        itemBuilder: (context, index) {
          final movie = animes[index];

          return GestureDetector(
              onTap: () => context.push('/movie/${movie.title}'),
              child: _Slide(anime: movie));
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Data anime;

  const _Slide({required this.anime});



  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              anime.image.url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black12),
                  );
                }
                return FadeIn(child: child);
              },
            )),
      ),
    );
  }
}
