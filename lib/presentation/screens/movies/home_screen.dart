import 'package:flutter/material.dart';

import '/presentation/widgets/widgets.dart';
import '/presentation/views/views.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  final int pageIndex;

  final List<Widget> children = const [
    HomeView(),
    SizedBox(),
    FavoriteView()
  ];

  const HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: children),
      bottomNavigationBar: CustomNavBar(currentIndex: pageIndex),
    );
  }
}
