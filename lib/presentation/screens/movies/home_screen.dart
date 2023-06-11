import 'package:flutter/material.dart';

import '/presentation/widgets/widgets.dart';
import '/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(keepPage: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Widget> children = const [
    HomeView(),
    PopularView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (controller.hasClients) {
      controller.animateToPage(widget.pageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    }

    return Scaffold(
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: children),
      bottomNavigationBar: CustomNavBar(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
