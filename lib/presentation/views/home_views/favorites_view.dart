import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {

  static const String name = 'favorite-view';

  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavoriteVie'),
      ),
      body: const Center(
        child: Text('FavoriteVie'),
      ),
    );
  }
}