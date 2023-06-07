import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;

    switch (location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return BottomNavigationBar(
        onTap: (index) {
          onItemTap(context, index);
        },
        currentIndex: getCurrentIndex(context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: 'Categorias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ]);
  }
}
