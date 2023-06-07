import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  //? Rutas y subrutas

  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),
      ]),
    GoRoute(path: '/', redirect: (_, __) => '/home/0',)
]);

// GlobalKey<NavigatorState> _rootNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'root');
// GlobalKey<NavigatorState> _otherNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'root');

// final GoRouter stateRouter = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     initialLocation: '/',
//     routes: <RouteBase>[
//       StatefulShellRoute(
//         builder: (context, state, navigationShell) {
//           return navigationShell;
//         },
//         navigatorContainerBuilder: (context, navigationShell, children) {
//           return HomeScreen(
//             navigationShell: navigationShell,
//             children: children,
//           );
//         },
//         branches: [
//           StatefulShellBranch(navigatorKey: _otherNavigatorKey, routes: [
//             GoRoute(
//                 path: '/',
//                 builder: (context, state) => const HomeView(),
//                 routes: [
//                   GoRoute(
//                     path: 'movie/:id',
//                     name: MovieScreen.name,
//                     builder: (context, state) {
//                       final movieId = state.pathParameters['id'] ?? 'no-id';
//                       return MovieScreen(movieId: movieId);
//                     },
//                   ),
//                 ]),
//           ]),
//           StatefulShellBranch(routes: [
//             GoRoute(
//               path: '/categorias',
//               builder: (context, state) => const FavoriteView(),
//             ),
//           ]),
//           StatefulShellBranch(
//               // navigatorKey: _otherNavigatorKey,
//               routes: [
//                 GoRoute(
//                   path: '/favorites',
//                   builder: (context, state) => const FavoriteView(),
//                 ),
//               ])
//         ],
//       )
//     ]);
