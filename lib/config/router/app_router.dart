import 'package:cinemapedia/infrastructure/datasources/classes.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          builder: (context, state) {
            final anime = state.extra as Data;
            return AnimeScreen(anime: anime);
          },
        ),
      ]),
]);
